require 'rails_helper'

RSpec.describe 'Api::V1::Admin::Organizations::Users', :type => :request do
  before(:each) do
    generate_oauth2_application(FactoryGirl.create(:user_as_admin).id)
  end

  #USER_REGEX = /{"id":".+","first_name":".+","last_name":".+","email":".+"}/

  before(:each) do
    @organization = FactoryGirl.create(:organization)
  end

  describe 'GET /organizations/:organization_id/users' do

    context 'when successful' do

      it 'should return a list of user objects' do
        organization_user = FactoryGirl.create(:organization_user, organization: @organization)

        get organization_users_url(@organization), {}, { 'Accept' => version, 'Authorization' => "Bearer #{@access_token.token}" }
        expect(response.body).to match(/^{"users":\[#{USER_REGEX}\],"current_page":\d,"total_count":\d,"total_pages":\d}$/)
      end

    end

  end

  describe 'POST /organizations/:organization_id/users' do

    context 'when invalid' do

      it 'should return an error response' do
        expect_validation_error { post organization_users_url(@organization), {}, { 'Accept' => version, 'Authorization' => "Bearer #{@access_token.token}" } }
      end

    end


    context 'when successful' do

      it 'should return a user object' do
        user_attributes = FactoryGirl.attributes_for(:user)

        post organization_users_url(@organization), user_attributes, { 'Accept' => version, 'Authorization' => "Bearer #{@access_token.token}" }
        expect(response.body).to match(/^#{USER_REGEX}$/)
      end

    end

  end

  describe 'DELETE /organizations/:organization_id/users/:id' do

    context 'when successful' do

      it 'should return a user object' do
        organization_user = FactoryGirl.create(:organization_user, organization: @organization)

        delete organization_user_url(@organization, organization_user.user), {}, { 'Accept' => version, 'Authorization' => "Bearer #{@access_token.token}" }
        expect(response.body).to match(/^#{USER_REGEX}$/)
      end

    end

  end

end
