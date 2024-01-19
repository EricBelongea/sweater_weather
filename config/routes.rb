Rails.application.routes.draw do
  namespace :api do
    namespace :v0 do
      resources :users, only: [:create]
      get '/forecast', to: 'forecasts#search'
      resources :sessions, only: :create
      resources :road_trip, only: :create
    end
    namespace :v1 do
      get '/munchies', to: 'munchies#search'
    end
  end
end
