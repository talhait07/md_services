require 'rails_helper'

RSpec.describe 'Api::V1::Patient::Cards', :type => :request do
  let(:stripe_helper) { StripeMock.create_test_helper }

  before(:each) do
    @user = FactoryGirl.create(:profile).user
    generate_oauth2_application(@user.id)
  end

  before(:each) do
    customer = Stripe::Customer.retrieve(@user.profile.stripe_id)
    @card = customer.cards.create({ card: stripe_helper.generate_card_token })
  end

  describe 'GET /cards' do

    context 'when successful' do

      it 'should return a list of card objects' do
        get cards_url, {}, { 'Accept' => version, 'Authorization' => "Bearer #{@access_token.token}" }
        expect(response.body).to match(/^\[#{CARD_REGEX}\]$/)
      end

    end

  end


  describe 'GET /cards/:id' do

    context 'when successful' do

      it 'should return an site object' do
        get card_url(@card[:id]), {}, { 'Accept' => version, 'Authorization' => "Bearer #{@access_token.token}" }
        expect(response.body).to match(/^#{CARD_REGEX}$/)
      end

    end

  end

  describe 'POST /cards' do

    context 'when invalid' do

      it 'should return an error response' do
        expect_validation_error { post cards_url, {}, { 'Accept' => version, 'Authorization' => "Bearer #{@access_token.token}" } }
      end

    end


    context 'when successful' do
      before(:each) do
        @card_token = stripe_helper.generate_card_token
      end

      it 'should return an site object' do
        post cards_url, { card: @card_token }, { 'Accept' => version, 'Authorization' => "Bearer #{@access_token.token}" }
        expect(response.body).to match(/^#{CARD_REGEX}$/)
      end

    end

  end

  describe 'PUT /cards/:id' do

    context 'when successful' do
      before(:each) do
        @card_token = stripe_helper.generate_card_token
      end

      it 'should return an site object' do
        put card_url(@card.id), { }, { 'Accept' => version, 'Authorization' => "Bearer #{@access_token.token}" }
        expect(response.body).to match(/^#{CARD_REGEX}$/)
      end

    end

  end

  describe 'DELETE /cards/:id' do

    context 'when successful' do

      it 'should return a card object' do
        delete card_url(@card[:id]), {}, { 'Accept' => version, 'Authorization' => "Bearer #{@access_token.token}" }
        expect(response.body).to match(/^#{CARD_REGEX}$/)
      end

    end

  end

  describe 'DELETE /cards/:id' do

    context 'when successful' do

      it 'should return a card object' do
        delete card_url(@card[:id]), {}, { 'Accept' => version, 'Authorization' => "Bearer #{@access_token.token}" }
        expect(response.body).to match(/^#{CARD_REGEX}$/)
      end

    end

  end

end
