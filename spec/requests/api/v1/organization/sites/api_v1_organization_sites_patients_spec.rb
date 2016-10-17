require 'rails_helper'

RSpec.describe 'Api::V1::Organization::Sites::Patients', :type => :request do
  before(:each) do
    @user = FactoryGirl.create(:user)
    generate_oauth2_application(@user)
    @organization_user = FactoryGirl.create(:organization_user, user: @user)
    @organization = @organization_user.organization
  end

  before(:each) do
    @site = FactoryGirl.create(:site, organization: @organization)
  end

  describe 'GET /sites/:site_id/patients' do

    context 'when successful' do

      it 'should return a list of patient objects' do
        FactoryGirl.create(:patient, site: @site, user: FactoryGirl.create(:profile).user)

        get site_patients_url(@site), {}, { 'Accept' => version, 'Authorization' => "Bearer #{@access_token.token}" }
        expect(response.body).to match(/^{"patients":\[#{PATIENT_REGEX}\],"current_page":\d,"total_count":\d,"total_pages":\d}$/)
      end

    end

  end


  describe 'GET /sites/:site_id/patients/:id' do

    context 'when successful' do

      it 'should return a patient object' do
        patient = FactoryGirl.create(:patient, site: @site, user: FactoryGirl.create(:profile).user)

        get site_patient_url(@site, patient), {}, { 'Accept' => version, 'Authorization' => "Bearer #{@access_token.token}" }
        expect(response.body).to match(/^#{PATIENT_REGEX}$/)
      end

    end

  end

  describe 'DELETE /sites/:site_id/patients/:id' do
    before(:each) do
      @patient = FactoryGirl.create(:patient, site: @site, user: FactoryGirl.create(:profile).user)
    end

    context 'when successful' do

      it 'should destroy a patient' do
        expect {
          delete site_patient_url(@site, @patient), {}, { 'Accept' => version, 'Authorization' => "Bearer #{@access_token.token}" }
        }.to change{ Patient.count }.by(-1)
      end

      it 'should return an patient object' do
        delete site_patient_url(@site, @patient), {}, { 'Accept' => version, 'Authorization' => "Bearer #{@access_token.token}" }
        expect(response.body).to match(/^#{PATIENT_REGEX}$/)
      end

    end

  end

end
