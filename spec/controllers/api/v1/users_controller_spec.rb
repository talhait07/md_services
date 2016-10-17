require 'rails_helper'

RSpec.describe Api::V1::UsersController, :type => :controller do
  setup_oauth2

  #let(:user)         { FactoryGirl.create(:user_as_admin) }

  describe 'GET /user' do
    it 'should be secured with sorcery' do
      require_oauth2 { get :show }
    end
  end

  describe 'PUT /user' do
    it 'should be secured with sorcery' do
      require_oauth2 { put :update }
    end
  end

  describe 'POST /users/validate' do
    it 'should be secured with sorcery' do
      require_oauth2 { post :validate }
    end

    context 'when invalid' do

      it 'should respond with 422' do
        post :validate, { first_name: '', format: :json }

        is_expected.to respond_with 422
      end

    end

    context 'when valid' do
      let(:user_attributes) { FactoryGirl.attributes_for(:user) }

      it 'should respond with 200' do
        post :validate, user_attributes.merge(format: :json)

        is_expected.to respond_with 200
      end

      it 'should not create a user' do
        expect {
          post :validate, user_attributes.merge(format: :json)
        }.to_not change{ User.count }
      end

    end
  end

end
