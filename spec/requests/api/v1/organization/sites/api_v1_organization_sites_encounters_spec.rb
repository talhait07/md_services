require 'rails_helper'

RSpec.describe 'Api::V1::Organization::Sites::Encounters', :type => :request do
  before(:each) do
    @user = FactoryGirl.create(:user)
    generate_oauth2_application(@user)
    @organization_user = FactoryGirl.create(:organization_user, user: @user)
    @organization = @organization_user.organization
  end

  #ENCOUNTER_REGEX = /{"id":".+","first_name":".+","last_name":".+","birth_date":".+","phone_number":".+","balance":".+"}/

  before(:each) do
    @site = FactoryGirl.create(:site, organization: @organization)
  end

  describe 'GET /sites/:site_id/encounters' do

    context 'when successful' do

      it 'should return a list of encounter objects' do
        FactoryGirl.create(:encounter, site: @site)

        get site_encounters_url(@site), {}, { 'Accept' => version, 'Authorization' => "Bearer #{@access_token.token}" }
        expect(response.body).to match(/^{"encounters":\[#{ENCOUNTER_REGEX}\],"current_page":\d,"total_count":\d,"total_pages":\d}$/)
      end

    end

  end

  describe 'GET /sites/:site_id/encounters/download' do

    context 'when successful' do

      it 'should return a list of encounter objects' do
        encounter = FactoryGirl.create(:encounter, site: @site)

        get download_site_encounters_url(@site), {}, { 'Accept' => version, 'Authorization' => "Bearer #{@access_token.token}" }
        expect(response.body).to eql(@site.encounters.order('created_at desc').to_csv)
      end

    end

  end


  describe 'GET /sites/:site_id/encounters/:id' do

    context 'when successful' do

      it 'should return an encounter object' do
        encounter = FactoryGirl.create(:encounter, site: @site)

        get site_encounter_url(@site, encounter), {}, { 'Accept' => version, 'Authorization' => "Bearer #{@access_token.token}" }
        expect(response.body).to match(/^#{ENCOUNTER_REGEX}$/)
      end

    end

  end

  describe 'DELETE /sites/:site_id/encounters/:id' do
    before(:each) do
      @encounter = FactoryGirl.create(:encounter, site: @site)
    end

    context 'when successful' do

      it 'should destroy an encounter' do
        expect {
          delete site_encounter_url(@site, @encounter), {}, { 'Accept' => version, 'Authorization' => "Bearer #{@access_token.token}" }
        }.to change{ Encounter.count }.by(-1)
      end

      it 'should return an encounter object' do
        delete site_encounter_url(@site, @encounter), {}, { 'Accept' => version, 'Authorization' => "Bearer #{@access_token.token}" }
        expect(response.body).to match(/^#{ENCOUNTER_REGEX}$/)
      end

    end

  end

end
