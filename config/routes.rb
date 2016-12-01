Rails.application.routes.draw do
  get 'apis/show'
  get 'apis/index' => 'users#apis'
  post '/add_api' => 'users#add_api'
  post '/remove_api' => 'users#remove_api'

  devise_for :users

  root to: 'visitors#index'
  resources :users
  resources :apis

end
