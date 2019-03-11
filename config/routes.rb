Rails.application.routes.draw do

  get 'hashtag/index'
  get 'hashtag/show'

  root 'users#index'

  resources :users
  resource :session, only: [:new, :create, :destroy]
  resources :questions, except: [:new, :show, :index]
end
