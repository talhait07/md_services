require 'rails_helper'

RSpec.describe Api::V1::PasswordResetsController, :type => :controller do
  setup_oauth2

  describe 'POST api/v1/password_resets' do
    it 'should be secured with oauth2' do
      require_oauth2 { post :create }
    end

    it 'should be successful if email found' do
      allow(User).to receive(:find_by_email) { FactoryGirl.build_stubbed(:user, id: SecureRandom.uuid) }
      post :create, email: 'biff@scrubpay.com', format: :json
      expect(response.status).to eq(200)
    end

    it 'should be successful if email not found' do
      post :create, email: 'biff@scrubpay.com', format: :json
      expect(response.status).to eq(200)
    end
  end
end
