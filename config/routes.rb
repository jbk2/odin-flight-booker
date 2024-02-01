Rails.application.routes.draw do
  devise_for :passengers

  root "flights#index"
  
  resources :flights, only: [:index] do
    collection do
      get :update_departure_airports
      get :update_arrival_airports
      get :update_departure_dates
    end
  end

  resources :airports, only: [:index]
  resources :bookings, only: [:new, :create, :show]
end
