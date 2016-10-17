Rails.application.routes.draw do
  use_doorkeeper do
    skip_controllers :applications, :authorizations, :authorized_applications, :token_info
  end

  api_version(module: 'api/v1', header: { name: 'Accept', value: 'application/vnd.scrubpay.com; version=1' }, defaults: { format: :json }) do
    resources :password_resets, only: [:create, :update]

    scope module: :admin, constraints: ScrubPay::Constraints::GodConstraint.new do
      resources :users, only: [:show, :update]
      resources :sites, only: [] do
        post :validate, on: :collection
      end

      resources :organizations, only: [:index, :show, :create, :update, :destroy] do
        scope module: 'organizations' do
          resources :sites, only: [:index, :show, :create, :update, :destroy]

          resources :users, only: [:index, :show, :create, :destroy]
        end
      end
    end

    scope module: :organization, constraints: ScrubPay::Constraints::OrganizationConstraint.new do
      resource  :organization, only: [:show, :update]

      resources :users, only: [:index, :show, :create, :update, :destroy]

      resources :sites, only: [:index, :show, :create, :update, :destroy] do
        scope module: 'sites' do
          resources :encounters, only: [:index, :show, :create, :destroy] do
            get :download, on: :collection
          end
          resources :patients, only: [:index, :show, :destroy]
        end
      end

      resource :account, only: [:show, :update]
    end

    scope module: :patient do#, constraints: ScrubPay::Constraints::OrganizationConstraint.new do
      resources :encounters, only: [:index, :show] do
        resources :payments, module: :encounters, only: [:index, :show, :create]
      end

      resources :sites, only: [:index, :show, :create]
      resources :cards, only: [:index, :show, :create, :update, :destroy]
    end

    resource :user, only: [:show, :update]
    resources :users, only: [:create] do
      post :validate, on: :collection
    end
  end

end
