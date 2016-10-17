require 'rails_helper'

RSpec.describe 'Api::V1::PasswordResets', :type => :request do
  before(:each) do
    generate_oauth2_application
  end

  describe 'PUT api/v1/password_resets' do
    before(:each) do
      @user = FactoryGirl.create(:user)

      @user.deliver_reset_password_instructions!
    end

    it 'should return success if password is valid' do
      put password_reset_path(@user.reset_password_token), { password: 'password', password_confirmation: 'password', access_token: @access_token.token }, { 'Accept' => version }
      expect(response.status).to eq(200)
    end

    it 'should return an access_token object' do
      put password_reset_path(@user.reset_password_token), { password: 'password', password_confirmation: 'password', access_token: @access_token.token }, { 'Accept' => version }
      expect(response.body).to match(/^#{ACCESS_TOKEN}$/)
    end

    it 'should return an error response when unsuccessful' do
      expect_validation_error { put password_reset_path(@user.reset_password_token), { access_token: @access_token.token }, { 'Accept' => version } }
    end

    it 'should render a 401 error response when token is invalid' do
      put password_reset_path(SecureRandom.hex), { access_token: @access_token.token }, { 'Accept' => version }
      expect(response.status).to eq(401)
    end
  end
end
