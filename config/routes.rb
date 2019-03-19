Rails.application.routes.draw do

  root 'users#index'

  resources :users
  resource :session, only: [:new, :create, :destroy]
  resources :questions, except: [:new, :show, :index]
  resources :hashtags, only: [:show]
end
