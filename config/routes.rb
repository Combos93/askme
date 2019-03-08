Rails.application.routes.draw do
  get 'hashtag/index'
    root 'users#index'

  resources :users
  resources :sessions, only: [:new, :create, :destroy]
  resources :questions, except: [:new, :show, :index]

  get 'sign_up' => 'users#new'

  get 'log_out' => 'sessions#destroy'
  get 'log_in' => 'sessions#new'

  # get 'hashtags' => 'hashtags#show'
end
