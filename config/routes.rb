Rails.application.routes.draw do
  get 'apis/show'
  get 'apis/index' => 'users#apis'
  post '/add_api' => 'users#add_api'
  post '/remove_api' => 'users#remove_api'
  get 'pages/about' => 'pages#about'
  post '/create_organization' => 'organizations#create'
  post '/leave_organization' => 'organizations#leave'
  post '/organizations/join' => 'organizations#join'

  devise_for :users

  authenticated :user do
    root 'visitors#index', as: :authenticated_root
  end

  root "pages#index"

  resources :users
  resources :apis
  resources :pages
  resources :organizations

end
