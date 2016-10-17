require 'rails_helper'

RSpec.describe 'Api::V1::Admin::Users', :type => :request do
  before(:each) do
    generate_oauth2_application(FactoryGirl.create(:user_as_admin).id)
  end

  #USER_REGEX = /{"id":".+","first_name":".+","last_name":".+","email":".+"}/

  describe 'GET /users/:id' do

    context 'when successful' do

      it 'should return an user object' do
        user = FactoryGirl.create(:organization_user).user

        get user_url(user), {}, { 'Accept' => version, 'Authorization' => "Bearer #{@access_token.token}" }
        expect(response.body).to match(/^#{USER_REGEX}$/)
      end

    end

  end

  describe 'PUT /users/:id' do
    before(:each) do
      @user = FactoryGirl.create(:organization_user).user
    end

    context 'when invalid' do

      it 'should return an error response' do
        expect_validation_error { put user_url(@user), { first_name: '' }, { 'Accept' => version, 'Authorization' => "Bearer #{@access_token.token}" } }
      end

    end


    context 'when successful' do

      it 'should return an organization object' do
        put user_url(@user), {}, { 'Accept' => version, 'Authorization' => "Bearer #{@access_token.token}" }
        expect(response.body).to match(/^#{USER_REGEX}$/)
      end

    end

  end

end
