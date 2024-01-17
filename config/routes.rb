Rails.application.routes.draw do
  devise_for :users
  
  # get 'flights/index'
  # get 'airports/index'

  resources :flights, only: [:index] do
    collection do
      get :update_departure_airports
      get :update_arrival_airports
    end
  end

  resources :airports, only: [:index]

  root "flights#index"
end
