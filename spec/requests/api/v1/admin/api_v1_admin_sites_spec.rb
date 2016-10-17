require 'rails_helper'

RSpec.describe 'Api::V1::Admin::Sites', :type => :request do
  before(:each) do
    generate_oauth2_application(FactoryGirl.create(:user_as_admin).id)
  end
  
  describe 'POST /sites/validate' do

    context 'when invalid' do

      it 'should return an error response' do
        expect_validation_error { post validate_sites_url, {}, { 'Accept' => version, 'Authorization' => "Bearer #{@access_token.token}" } }
      end

    end


    context 'when successful' do
      before(:each) do
        @site_attributes = FactoryGirl.attributes_for(:site, organization: nil)
      end

      it 'should not create a new site' do
        expect {
          post validate_sites_url, @site_attributes, { 'Accept' => version, 'Authorization' => "Bearer #{@access_token.token}" }
        }.to_not change{ Site.count }
      end

      it 'should return a site object' do
        post validate_sites_url, @site_attributes, { 'Accept' => version, 'Authorization' => "Bearer #{@access_token.token}" }
        expect(response.body).to match(/^#{SITE_REGEX}$/)
      end

    end

  end

end
