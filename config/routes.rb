require 'sidekiq/web'

Rails.application.routes.draw do
  devise_for :passengers

  mount Sidekiq::Web => '/sidekiq'

  root "flights#index"
  
  resources :flights, only: [:index] do
    collection do
      # routes for FlightSearchForm Stimulus controller
      get :update_departure_airports
      get :update_arrival_airports
      get :update_departure_dates
    end
  end

  resources :airports, only: [:index]

  resources :bookings, only: [:new, :create, :show, :index] do
    patch :update_booking_owner_password, on: :member
  end
end
