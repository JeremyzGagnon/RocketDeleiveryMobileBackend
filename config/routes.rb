Rails.application.routes.draw do
  resources :product_orders
  resources :orders
  resources :order_statuses
  resources :products
  resources :customers
  resources :restaurants  
  resources :employees
  resources :addresses
  devise_for :users
  root to: "home#index"

  # devise_for :users, controllers: {
  #   sessions: 'users/sessions'
  #   }
  #     devise_scope :user do  
  #   get '/users/sign_out' => 'devise/sessions#destroy'     
  # end
  
  namespace :api do
    post 'login', to: 'auth#index'
    get 'products', to: 'products#index'
    get 'restaurants', to: 'restaurants#index'
    get 'orders', to: 'orders#index'
    post 'orders', to: 'orders#create'
    post 'order/:id/status', to: 'orders#set_status'
  end



end




