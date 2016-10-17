require 'rails_helper'

RSpec.describe Api::V1::Admin::OrganizationsController, :type => :controller do
  setup_oauth2

  let(:organization) { FactoryGirl.create(:organization) }

  describe 'GET /organizations' do
    it 'should be secured with sorcery' do
      require_oauth2 { get :index }
    end
  end

  describe 'GET /organizations/:id' do
    it 'should be secured with sorcery' do
      require_oauth2 { get :show, { id: organization.id } }
    end
  end

  describe 'POST /organizations' do
    it 'should be secured with sorcery' do
      require_oauth2 { post :create }
    end

    context 'when is invalid' do

      it 'should respond with 422' do
        post :create, { format: :json }

        is_expected.to respond_with 422
      end

    end

    context 'when is valid' do
      let(:organization_attributes) { FactoryGirl.attributes_for(:organization) }

      it 'should create a new organization' do
        expect {
          post :create, organization_attributes.merge(format: :json)
        }.to change{ Organization.count }.by(1)
      end

      it 'should not create a new organization when only validating' do
        expect {
          post :create, organization_attributes.merge(validate: true, format: :json)
        }.to_not change{ Organization.count }
      end

    end
  end

  describe 'PUT /organizations/:id' do
    it 'should be secured with sorcery' do
      require_oauth2 { put :update, { id: organization.id } }
    end
  end

  describe 'DELETE /organizations/:id' do
    before(:each) do
      @organization = FactoryGirl.create(:organization)
    end

    it 'should be secured with sorcery' do
      require_oauth2 { delete :destroy, { id: @organization.id } }
    end

    it 'should destroy organization' do
      expect {
        delete :destroy, { id: @organization.id, format: :json }
      }.to change{ Organization.count }.by(-1)
    end
  end
end
