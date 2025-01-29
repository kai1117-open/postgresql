Rails.application.routes.draw do
  root "home#index"

  devise_for :users
  resources :tournaments
  resources :matches, only: [:edit, :update]
  resources :users, only: [:show]
  get "dashboard", to: "dashboard#index"
  namespace :admin do
    get "/", to: "admin#index", as: "index"
    resources :users, only: [:index]
  end
end