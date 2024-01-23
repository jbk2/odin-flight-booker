Rails.application.routes.draw do
  # get 'bookings/new'
  # get 'bookings/create'
  devise_for :users
  
  # get 'flights/index'
  # get 'airports/index'

  resources :flights, only: [:index] do
    collection do
      get :update_departure_airports
      get :update_arrival_airports
      get :update_departure_dates
    end
  end

  resources :airports, only: [:index]
  resources :bookings, only: [:new, :create, :show]

  root "flights#index"
end
