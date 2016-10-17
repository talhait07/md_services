require 'rails_helper'

RSpec.describe Api::V1::Admin::Organizations::UsersController, :type => :controller do
  setup_oauth2

  let(:organization) { FactoryGirl.create(:organization) }
  let(:user)         { FactoryGirl.create(:organization_user, organization: organization ).user }

  describe 'GET /organizations/:organization_id/users' do
    it 'should be secured with sorcery' do
      require_oauth2 { get :index, { organization_id: organization.id } }
    end
  end

  describe 'POST /organizations/:organization_id/users' do
    it 'should be secured with sorcery' do
      require_oauth2 { post :create, { organization_id: organization.id } }
    end

    context 'when is invalid' do

      it 'should respond with 422' do
        post :create, { organization_id: organization.id, format: :json }

        is_expected.to respond_with 422
      end

    end

    context 'when is valid' do
      let(:user_attributes) { FactoryGirl.attributes_for(:user) }

      it 'should create a new user' do
        expect {
          post :create, user_attributes.merge(organization_id: organization.id, format: :json)
        }.to change{ User.count }.by(1)
      end
    end
  end

  describe 'DELETE /organizations/:organization_id/users/:id' do
    before(:each) do
      @user = FactoryGirl.create(:organization_user, organization: organization).user
    end

    it 'should be secured with sorcery' do
      require_oauth2 { delete :destroy, { organization_id: organization.id, id: @user.id } }
    end

    it 'should destroy user' do
      expect {
        delete :destroy, { organization_id: organization.id, id: @user.id, format: :json }
      }.to change{ User.count }.by(-1)
    end
  end
end
