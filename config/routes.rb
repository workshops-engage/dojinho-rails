DojinhoRails::Application.routes.draw do
  get "home/index"
  resources :movies, only: [:index, :show]
  resources :favorites
  devise_for :users

  ActiveAdmin.routes(self)

  devise_for :admin_users, ActiveAdmin::Devise.config
  resources :users, only: [:index, :show]
  root to: "home#index"
end
