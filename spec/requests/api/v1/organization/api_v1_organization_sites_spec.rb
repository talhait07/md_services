require 'rails_helper'

RSpec.describe 'Api::V1::Organization::Sites', :type => :request do
  before(:each) do
    @user = FactoryGirl.create(:user)
    generate_oauth2_application(@user)
    @organization_user = FactoryGirl.create(:organization_user, user: @user)
    @organization = @organization_user.organization
  end

  #SITE_REGEX = /{"id":".+","name":".+","address_1":".+","address_2":(".+"|null),"city":".+","state":".+","postal_code":".+","phone_number":".+","customer_discount":".+","organization":".+"}/

  describe 'GET /sites' do

    context 'when successful' do

      it 'should return a list of site objects' do
        FactoryGirl.create(:site, organization: @organization)

        get sites_url, {}, { 'Accept' => version, 'Authorization' => "Bearer #{@access_token.token}" }
        expect(response.body).to match(/^{"sites":\[#{SITE_REGEX}\],"current_page":\d,"total_count":\d,"total_pages":\d}$/)
      end

    end

  end


  describe 'GET /sites/:id' do

    context 'when successful' do

      it 'should return an site object' do
        site = FactoryGirl.create(:site, organization: @organization)

        get site_url(site), {}, { 'Accept' => version, 'Authorization' => "Bearer #{@access_token.token}" }
        expect(response.body).to match(/^#{SITE_REGEX}$/)
      end

    end

  end

  describe 'POST /sites' do

    context 'when invalid' do

      it 'should return an error response' do
        expect_validation_error { post sites_url, {}, { 'Accept' => version, 'Authorization' => "Bearer #{@access_token.token}" } }
      end

    end


    context 'when successful' do
      before(:each) do
        @site_attributes = FactoryGirl.attributes_for(:site, organization: @organization)
      end

      it 'should create a new site' do
        expect {
          post sites_url, @site_attributes, { 'Accept' => version, 'Authorization' => "Bearer #{@access_token.token}" }
        }.to change{ Site.count }.by(1)
      end

      it 'should return an site object' do
        post sites_url, @site_attributes, { 'Accept' => version, 'Authorization' => "Bearer #{@access_token.token}" }
        expect(response.body).to match(/^#{SITE_REGEX}$/)
      end

    end

  end

  describe 'PUT /sites/:id' do
    before(:each) do
      @site = FactoryGirl.create(:site, organization: @organization)
    end

    context 'when invalid' do

      it 'should return an error response' do
        expect_validation_error { put site_url(@site), { name: '' }, { 'Accept' => version, 'Authorization' => "Bearer #{@access_token.token}" } }
      end

    end


    context 'when successful' do

      it 'should return an site object' do
        put site_url(@site), {}, { 'Accept' => version, 'Authorization' => "Bearer #{@access_token.token}" }
        expect(response.body).to match(/^#{SITE_REGEX}$/)
      end

    end

  end

  describe 'DELETE /sites/:id' do
    before(:each) do
      @site = FactoryGirl.create(:site, organization: @organization)
    end

    context 'when successful' do

      it 'should destroy a site' do
        expect {
          delete site_url(@site), {}, { 'Accept' => version, 'Authorization' => "Bearer #{@access_token.token}" }
        }.to change{ Site.count }.by(-1)
      end

      it 'should return a site object' do
        delete site_url(@site), {}, { 'Accept' => version, 'Authorization' => "Bearer #{@access_token.token}" }
        expect(response.body).to match(/^#{SITE_REGEX}$/)
      end

    end

  end

end
