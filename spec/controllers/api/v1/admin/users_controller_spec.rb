require 'rails_helper'

RSpec.describe Api::V1::Admin::UsersController, :type => :controller do
  setup_oauth2

  let(:user) { FactoryGirl.create(:organization_user).user }

  describe 'GET /users/:id' do
    it 'should be secured with sorcery' do
      require_oauth2 { get :show, { id: user.id } }
    end
  end

  describe 'PUT /users/:id' do
    it 'should be secured with sorcery' do
      require_oauth2 { put :update, { id: user.id } }
    end
  end
end
