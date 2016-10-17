require 'rails_helper'

RSpec.describe 'Api::V1::Admin::Organizations::Sites', :type => :request do
  before(:each) do
    generate_oauth2_application(FactoryGirl.create(:user_as_admin).id)
  end

  #SITE_REGEX = /{"id":".+","name":".+","address_1":".+","address_2":(".+"|null),"city":".+","state":".+","postal_code":".+","phone_number":".+","customer_discount":".+","organization":".+"}/

  before(:each) do
    @organization = FactoryGirl.create(:organization)
  end

  describe 'GET /organizations/:organization_id/sites' do

    context 'when successful' do

      it 'should return a list of site objects' do
        FactoryGirl.create(:site, organization: @organization)

        get organization_sites_url(@organization), {}, { 'Accept' => version, 'Authorization' => "Bearer #{@access_token.token}" }
        expect(response.body).to match(/^{"sites":\[#{SITE_REGEX}\],"current_page":\d,"total_count":\d,"total_pages":\d}$/)
      end

    end

  end


  describe 'GET /organizations/:organization_id/sites/:id' do

    context 'when successful' do

      it 'should return an site object' do
        site = FactoryGirl.create(:site, organization: @organization)

        get organization_site_url(@organization, site), {}, { 'Accept' => version, 'Authorization' => "Bearer #{@access_token.token}" }
        expect(response.body).to match(/^#{SITE_REGEX}$/)
      end

    end

  end

  describe 'POST /organizations/:organization_id/sites' do

    context 'when invalid' do

      it 'should return an error response' do
        expect_validation_error { post organization_sites_url(@organization), {}, { 'Accept' => version, 'Authorization' => "Bearer #{@access_token.token}" } }
      end

    end


    context 'when successful' do

      it 'should return an site object' do
        site_attributes = FactoryGirl.attributes_for(:site, organization: @organization)

        post organization_sites_url(@organization), site_attributes, { 'Accept' => version, 'Authorization' => "Bearer #{@access_token.token}" }
        expect(response.body).to match(/^#{SITE_REGEX}$/)
      end

    end

  end

  describe 'PUT /organizations/:organization_id/sites/:id' do
    before(:each) do
      @site = FactoryGirl.create(:site, organization: @organization)
    end

    context 'when invalid' do

      it 'should return an error response' do
        expect_validation_error { put organization_site_url(@organization, @site), { name: '' }, { 'Accept' => version, 'Authorization' => "Bearer #{@access_token.token}" } }
      end

    end


    context 'when successful' do

      it 'should return an site object' do
        put organization_site_url(@organization, @site), {}, { 'Accept' => version, 'Authorization' => "Bearer #{@access_token.token}" }
        expect(response.body).to match(/^#{SITE_REGEX}$/)
      end

    end

  end

  describe 'DELETE /organizations/:organization_id/sites/:id' do

    context 'when successful' do

      it 'should return a site object' do
        site = FactoryGirl.create(:site, organization: @organization)

        delete organization_site_url(@organization, site), {}, { 'Accept' => version, 'Authorization' => "Bearer #{@access_token.token}" }
        expect(response.body).to match(/^#{SITE_REGEX}$/)
      end

    end

  end

end
