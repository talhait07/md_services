require 'rails_helper'

RSpec.describe 'Api::V1::Patient::Encounters', :type => :request do
  before(:each) do
    @user = FactoryGirl.create(:user)
    generate_oauth2_application(@user)
    @patient = FactoryGirl.create(:patient, user: @user)
  end

  describe 'GET /encounters' do

    context 'when successful' do

      it 'should return a list of encounter objects' do
        FactoryGirl.create(:encounter, site: @patient.site, patient: @patient)

        get encounters_url, {}, { 'Accept' => version, 'Authorization' => "Bearer #{@access_token.token}" }
        expect(response.body).to match(/^{"encounters":\[#{ENCOUNTER_REGEX}\],"current_page":\d,"total_count":\d,"total_pages":\d}$/)
      end

    end

  end


  describe 'GET /encounters/:id' do

    context 'when successful' do

      it 'should return an encounter object' do
        encounter = FactoryGirl.create(:encounter, site: @patient.site, patient: @patient)

        get encounter_url(encounter), {}, { 'Accept' => version, 'Authorization' => "Bearer #{@access_token.token}" }
        expect(response.body).to match(/^#{ENCOUNTER_REGEX}$/)
      end

    end

  end

end
