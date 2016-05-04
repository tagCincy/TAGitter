Rails.application.routes.draw do

  namespace :api, defaults: { format: 'json'} do
    namespace :v1 do
      namespace :public do
        resources :posts, only: [:index, :show]
        resources :users, only: [:show]
      end
    end
  end

end
