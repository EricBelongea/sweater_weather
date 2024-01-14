Rails.application.routes.draw do
  namespace :api do
    namespace :v0 do
      resources :users, only: [:create]
      get '/forecast', to: 'forecasts#search'
      resources :sessions, only: :create
    end
  end
end
