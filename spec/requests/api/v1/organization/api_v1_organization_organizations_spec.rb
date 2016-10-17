require 'rails_helper'

RSpec.describe 'Api::V1::Organization::Organizations', :type => :request do
  before(:each) do
    @user = FactoryGirl.create(:user)
    generate_oauth2_application(@user.id)
    @organization_user = FactoryGirl.create(:organization_user, user: @user)
    @organization = @organization_user.organization
  end

  #ORGANIZATION_REGEX = /{"id":".+","name":".+","npi_number":".+","positions":\d+,"address_1":".+","address_2":(".+"|null),"city":".+","state":".+","postal_code":".+","phone_number":".+","url":".+"}/

  describe 'GET /organization' do

    context 'when successful' do

      it 'should return an organization object' do
        get '/organization', {}, { 'Accept' => version, 'Authorization' => "Bearer #{@access_token.token}" }
        expect(response.body).to match(/^#{ORGANIZATION_REGEX}$/)
      end

    end

  end

  describe 'PUT /organization' do

    context 'when invalid' do

      it 'should return an error response' do
        expect_validation_error { put '/organization', { name: '' }, { 'Accept' => version, 'Authorization' => "Bearer #{@access_token.token}" } }
      end

    end


    context 'when successful' do

      it 'should return an organization object' do
        put '/organization', {}, { 'Accept' => version, 'Authorization' => "Bearer #{@access_token.token}" }
        expect(response.body).to match(/^#{ORGANIZATION_REGEX}$/)
      end

    end

  end

end
