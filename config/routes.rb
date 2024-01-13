Rails.application.routes.draw do
  devise_for :users
  
  get 'flights/search'

  root "flights#search"
end
