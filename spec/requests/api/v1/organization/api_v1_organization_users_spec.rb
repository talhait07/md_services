require 'rails_helper'

RSpec.describe 'Api::V1::Organization::Users', :type => :request do
  before(:each) do
    @user = FactoryGirl.create(:user)
    generate_oauth2_application(@user)
    @organization_user = FactoryGirl.create(:organization_user, user: @user)
    @organization = @organization_user.organization
  end

  #USER_REGEX = /{"id":".+","first_name":".+","last_name":".+","email":".+"}/  

  describe 'GET /users' do

    context 'when successful' do

      it 'should return a list of user objects' do
        FactoryGirl.create(:organization_user, organization: @organization)

        get users_url, {}, { 'Accept' => version, 'Authorization' => "Bearer #{@access_token.token}" }
        expect(response.body).to match(/^{"users":\[#{USER_REGEX}\],"current_page":\d,"total_count":\d,"total_pages":\d}$/)
      end

    end

  end


  describe 'GET /users/:id' do

    context 'when successful' do

      it 'should return a user object' do
        user = FactoryGirl.create(:organization_user, organization: @organization).user

        get user_url(user), {}, { 'Accept' => version, 'Authorization' => "Bearer #{@access_token.token}" }
        expect(response.body).to match(/^#{USER_REGEX}$/)
      end

    end

  end

  describe 'POST /users' do

    context 'when invalid' do

      it 'should return an error response' do
        expect_validation_error { post users_url, {}, { 'Accept' => version, 'Authorization' => "Bearer #{@access_token.token}" } }
      end

    end


    context 'when successful' do
      before(:each) do
        @user_attributes = FactoryGirl.attributes_for(:user)
      end

      it 'should create a new user' do
        expect {
          post users_url, @user_attributes, { 'Accept' => version, 'Authorization' => "Bearer #{@access_token.token}" }
        }.to change{ User.count }.by(1)
      end

      it 'should create a new organization user' do
        expect {
          post users_url, @user_attributes, { 'Accept' => version, 'Authorization' => "Bearer #{@access_token.token}" }
        }.to change{ OrganizationUser.count }.by(1)
      end

      it 'should return a user object' do
        post users_url, @user_attributes, { 'Accept' => version, 'Authorization' => "Bearer #{@access_token.token}" }
        expect(response.body).to match(/^#{USER_REGEX}$/)
      end

    end

  end

  describe 'PUT /users/:id' do
    before(:each) do
      @user = FactoryGirl.create(:organization_user, organization: @organization).user
    end

    context 'when invalid' do

      it 'should return an error response' do
        expect_validation_error { put user_url(@user), { first_name: '' }, { 'Accept' => version, 'Authorization' => "Bearer #{@access_token.token}" } }
      end

    end


    context 'when successful' do

      it 'should return a user object' do
        put user_url(@user), {}, { 'Accept' => version, 'Authorization' => "Bearer #{@access_token.token}" }
        expect(response.body).to match(/^#{USER_REGEX}$/)
      end

    end

  end

  describe 'DELETE /users/:id' do

    context 'when is myself' do

      it 'should return a bad request' do
        expect_bad_request_error { delete user_url(@user), {}, { 'Accept' => version, 'Authorization' => "Bearer #{@access_token.token}" } }
      end
    end

    context 'when successful' do
      before(:each) do
        @user = FactoryGirl.create(:organization_user, organization: @organization).user
      end

      it 'should destroy a user' do
        expect {
          delete user_url(@user), {}, { 'Accept' => version, 'Authorization' => "Bearer #{@access_token.token}" }
        }.to change{ User.count }.by(-1)
      end

      it 'should destroy a organization user' do
        expect {
          delete user_url(@user), {}, { 'Accept' => version, 'Authorization' => "Bearer #{@access_token.token}" }
        }.to change{ OrganizationUser.count }.by(-1)
      end

      it 'should return a user object' do
        delete user_url(@user), {}, { 'Accept' => version, 'Authorization' => "Bearer #{@access_token.token}" }
        expect(response.body).to match(/^#{USER_REGEX}$/)
      end

    end

  end

end
