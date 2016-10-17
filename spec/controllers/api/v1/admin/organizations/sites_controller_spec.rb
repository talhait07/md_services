require 'rails_helper'

RSpec.describe Api::V1::Admin::Organizations::SitesController, :type => :controller do
  setup_oauth2

  let(:organization) { FactoryGirl.create(:organization) }
  let(:site)         { FactoryGirl.create(:site, organization: organization )}

  describe 'GET /organizations/:organization_id/sites' do
    it 'should be secured with sorcery' do
      require_oauth2 { get :index, { organization_id: organization.id } }
    end
  end

  describe 'GET /organizations/:organization_id/sites/:id' do
    #let(:site) { FactoryGirl.create(:site, organization: organization) }

    it 'should be secured with sorcery' do
      require_oauth2 { get :show, { organization_id: organization.id, id: site.id } }
    end
  end

  describe 'POST /organizations/:organization_id/sites' do
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
      let(:site_attributes) { FactoryGirl.attributes_for(:site, organization: organization) }

      it 'should create a new site' do
        expect {
          post :create, site_attributes.merge(organization_id: organization.id, format: :json)
        }.to change{ Site.count }.by(1)
      end
    end
  end

  describe 'PUT /organizations/:organization_id/sites/:id' do
    #let(:site) { FactoryGirl.create(:site, organization: organization) }

    it 'should be secured with sorcery' do
      require_oauth2 { put :update, { organization_id: organization.id, id: site.id } }
    end
  end

  describe 'DELETE /organizations/:organization_id/sites/:id' do
    before(:each) do
      @site = FactoryGirl.create(:site, organization: organization)
    end

    it 'should be secured with sorcery' do
      require_oauth2 { delete :destroy, { organization_id: organization.id, id: @site.id } }
    end

    it 'should destroy site' do
      expect {
        delete :destroy, { organization_id: organization.id, id: @site.id, format: :json }
      }.to change{ Site.count }.by(-1)
    end
  end
end
