Rails.application.routes.draw do
  devise_for :users
  
  # get 'flights/index'

  resources :flights, only: [:index]

  root "flights#index"
end
