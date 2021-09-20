Rails.application.routes.draw do
  get '/ping', to: "ping#index"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      post '/login', to: 'login#index'
      resources :users do
        put '/change-password', to: 'users#change_password'
      end
      resources :habits do
      end
    end
  end
end
