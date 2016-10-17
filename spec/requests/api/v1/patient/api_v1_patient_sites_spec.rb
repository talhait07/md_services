require 'rails_helper'

RSpec.describe 'Api::V1::Patient::Sites', :type => :request do
  before(:each) do
    @user = FactoryGirl.create(:user)
    generate_oauth2_application(@user)
  end

  describe 'GET /sites' do

    context 'when successful' do

      it 'should return a list of site objects' do
        FactoryGirl.create(:patient, user: @user)

        get sites_url, {}, { 'Accept' => version, 'Authorization' => "Bearer #{@access_token.token}" }
        expect(response.body).to match(/^\[#{SITE_REGEX}\]$/)
      end

    end

  end


  describe 'GET /sites/:id' do

    context 'when successful' do

      it 'should return an site object' do
        site = FactoryGirl.create(:patient, user: @user).site

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
        @site = FactoryGirl.create(:site)
      end

      it 'should create a new patient' do
        expect {
          post sites_url, { site_number: @site.site_number }, { 'Accept' => version, 'Authorization' => "Bearer #{@access_token.token}" }
        }.to change{ Patient.count }.by(1)
      end

      it 'should return an site object' do
        post sites_url, { site_number: @site.site_number }, { 'Accept' => version, 'Authorization' => "Bearer #{@access_token.token}" }
        expect(response.body).to match(/^#{SITE_REGEX}$/)
      end

    end

  end

end
