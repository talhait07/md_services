require 'rails_helper'

RSpec.describe 'Api::V1::Patient::Sites', :type => :request do
  before(:each) do
    @user = FactoryGirl.create(:user)
    generate_oauth2_application(@user)
    patient = FactoryGirl.create(:patient, user: @user)
    @encounter = FactoryGirl.create(:encounter, site: patient.site, patient: patient)
  end

  describe 'GET /encounters/:encounter_id/payments' do

    context 'when successful' do

      it 'should return a list of payment objects' do
        FactoryGirl.create(:payment, encounter: @encounter)

        get encounter_payments_url(@encounter), {}, { 'Accept' => version, 'Authorization' => "Bearer #{@access_token.token}" }
        expect(response.body).to match(/^\[#{PAYMENT_REGEX}\]$/)
      end

    end

  end


  describe 'GET /encounters/:encounter_id/payments/:id' do

    context 'when successful' do

      it 'should return an payment object' do
        payment = FactoryGirl.create(:payment, encounter: @encounter)

        get encounter_payment_url(@encounter, payment), {}, { 'Accept' => version, 'Authorization' => "Bearer #{@access_token.token}" }
        expect(response.body).to match(/^#{PAYMENT_REGEX}$/)
      end

    end

  end

end
