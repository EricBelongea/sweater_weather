Rails.application.routes.draw do
  namespace :api do
    namespace :v0 do
      resources :users, only: [:create]
      resources :forecasts, only: :index 
      get '/forecast', to: 'forecasts#search'
    end
  end
end
