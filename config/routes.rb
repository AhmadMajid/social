Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "home#index"

  resources :vibrations, only: [:show, :create] do
    resources :likes, only: [:create, :destroy]
    resources :bookmarks, only: [:create, :destroy]
    resources :revibrations, only: [:create, :destroy]
    resources :reply_vibrations, only: :create
  end

  resources :bookmarks, only: :index

  get :dashboard, to: "dashboard#index"
  get :profile, to: "profile#show"
  put :profile, to: "profile#update"

  resources :usernames, only: [:new, :update]

  resources :users, only: :show do
    resources :followings, only: [:create, :destroy]
  end

  resources :hashtags, only: [:index, :show], path: "/explore"

  resources :message_threads, only: :index, path: "/messages" do
    resources :messages, only: :index
  end

  resources :messages, only: :create

  resources :notifications, only: [:index, :destroy]

  get "/vibration_polling", to: "vibration_polling#index"
end
