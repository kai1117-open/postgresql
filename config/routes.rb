Rails.application.routes.draw do
  root "home#index"

  devise_for :users
  
  resources :tournaments do
    post "join", on: :member
    post "previous_round", on: :member
    post "next_round", on: :member  # ✅ 「次のラウンドへ」ボタン用
    resources :matches, only: [:index, :show, :create, :edit, :update]
  end

  resources :users, only: [:show]

  get "dashboard", to: "dashboard#index"

  namespace :admin do
    get "/", to: "admin#index", as: "index"
    resources :users, only: [:index]
  end
end
