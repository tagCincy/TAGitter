Rails.application.routes.draw do

  mount_devise_token_auth_for 'User', at: 'api/v1/auth', skip: [:omniauth_callbacks], controllers: {
      registrations:  'devise_overrides/registrations',
      sessions:       'devise_overrides/sessions'
  }

  namespace :api, defaults: { format: 'json' } do
    namespace :v1 do

      namespace :public do
        resources :posts, only: [:index, :show]
        resources :users, only: [:show]
      end

      namespace :authenticated do
        resources :users, only: [:show, :update]
      end

    end
  end

end
