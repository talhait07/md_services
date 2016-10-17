require 'rails_helper'

RSpec.describe 'Api::V1::Users', :type => :request do
  before(:each) do

    #@patient = FactoryGirl.create(:patient, user: @user)
  end

  describe 'GET /user' do
    before(:each) do
      @user = FactoryGirl.create(:user)
      generate_oauth2_application(@user.id)
    end

    context 'when successful' do

      it 'should return a user object' do
        #FactoryGirl.create(:patient, user: @user)
        #FactoryGirl.create(:site, organization: @organization)

        get '/user', {}, { 'Accept' => version, 'Authorization' => "Bearer #{@access_token.token}" }
        expect(response.body).to match(/^#{USER_REGEX}$/)
      end

    end

  end

  describe 'POST /users' do
    before(:each) do
      #@user = FactoryGirl.create(:user)
      generate_oauth2_application#(@user.id)
    end

    context 'when invalid' do
      it 'should return an error response' do
        expect_validation_error { post users_url, {}, { 'Accept' => version, 'Authorization' => "Bearer #{@access_token.token}" } }
      end

    end


    context 'when successful' do
      before(:each) do
        profile_attributes = FactoryGirl.attributes_for(:profile)
        @user_attributes = FactoryGirl.attributes_for(:user).merge profile_attributes
      end

      it 'should create a new user' do
        expect {
          post users_url, @user_attributes, { 'Accept' => version, 'Authorization' => "Bearer #{@access_token.token}" }
        }.to change{ User.count }.by(1)
      end

      it 'should create a new profile' do
        expect {
          post users_url, @user_attributes, { 'Accept' => version, 'Authorization' => "Bearer #{@access_token.token}" }
        }.to change{ Profile.count }.by(1)
      end

      it 'should return an site object' do
        post users_url, @user_attributes, { 'Accept' => version, 'Authorization' => "Bearer #{@access_token.token}" }
        expect(response.body).to match(/^#{ACCESS_TOKEN}$/)
      end

    end

  end

end
