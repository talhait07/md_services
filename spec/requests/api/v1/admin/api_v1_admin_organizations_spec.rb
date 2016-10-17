require 'rails_helper'

RSpec.describe 'Api::V1::Admin::Organizations', :type => :request do
  before(:each) do
    generate_oauth2_application(FactoryGirl.create(:user_as_admin).id)
  end

  #ORGANIZATION_REGEX = /{"id":".+","name":".+","npi_number":".+","positions":\d+,"address_1":".+","address_2":(".+"|null),"city":".+","state":".+","postal_code":".+","phone_number":".+","url":".+"}/

  describe 'GET /organizations' do

    context 'when successful' do

      it 'should return a list of organization objects' do
        FactoryGirl.create(:organization)

        get organizations_url, {}, { 'Accept' => version, 'Authorization' => "Bearer #{@access_token.token}" }
        expect(response.body).to match(/^{"organizations":\[#{ORGANIZATION_REGEX}\],"current_page":\d,"total_count":\d,"total_pages":\d}$/)
      end

    end

  end


  describe 'GET /organizations/:id' do

    context 'when successful' do

      it 'should return an organization object' do
        organization = FactoryGirl.create(:organization)

        get organization_url(organization), {}, { 'Accept' => version, 'Authorization' => "Bearer #{@access_token.token}" }
        expect(response.body).to match(/^#{ORGANIZATION_REGEX}$/)
      end

    end

  end

  describe 'POST /organizations' do

    context 'when invalid' do

      it 'should return an error response' do
        expect_validation_error { post organizations_url, {}, { 'Accept' => version, 'Authorization' => "Bearer #{@access_token.token}" } }
      end

    end


    context 'when successful' do

      it 'should return an organization object' do
        organization_attributes = FactoryGirl.attributes_for(:organization)

        post organizations_url, organization_attributes, { 'Accept' => version, 'Authorization' => "Bearer #{@access_token.token}" }
        expect(response.body).to match(/^#{ORGANIZATION_REGEX}$/)
      end

    end

  end

  describe 'PUT /organizations/:id' do
    before(:each) do
      @organization = FactoryGirl.create(:organization)
    end

    context 'when invalid' do

      it 'should return an error response' do
        expect_validation_error { put organization_url(@organization), { name: '' }, { 'Accept' => version, 'Authorization' => "Bearer #{@access_token.token}" } }
      end

    end


    context 'when successful' do

      it 'should return an organization object' do
        put organization_url(@organization), {}, { 'Accept' => version, 'Authorization' => "Bearer #{@access_token.token}" }
        expect(response.body).to match(/^#{ORGANIZATION_REGEX}$/)
      end

    end

  end

  describe 'DELETE /organizations/:id' do

    context 'when successful' do

      it 'should return an organization object' do
        organization = FactoryGirl.create(:organization)

        delete organization_url(organization), {}, { 'Accept' => version, 'Authorization' => "Bearer #{@access_token.token}" }
        expect(response.body).to match(/^#{ORGANIZATION_REGEX}$/)
      end

    end

  end

end
