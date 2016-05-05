Rails.application.routes.draw do

  namespace :api, defaults: { format: 'json' } do

    namespace :v1 do

      mount_devise_token_auth_for 'User', at: 'auth', skip: [:omniauth_callbacks], controllers: {
          registrations:  'devise_overrides/registrations',
          sessions:       'devise_overrides/sessions'
      }

      namespace :public do
        resources :posts, only: [:index, :show]
        resources :users, only: [:show]
      end

    end

  end

end
