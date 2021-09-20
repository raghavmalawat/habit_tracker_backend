Rails.application.routes.draw do
  get '/ping', to: "ping#index"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :users do
        put '/change-password', to: 'users#change_password'
        resources :habits
      end
    end
  end
end
