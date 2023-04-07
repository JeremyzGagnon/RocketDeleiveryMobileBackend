Rails.application.routes.draw do
  resources :product_orders
  resources :orders
  resources :order_statuses
  resources :products
  resources :customers
  resources :restaurants  
  resources :employees
  resources :addresses
  devise_for :users, controllers: {
    sessions: 'users/sessions'
    }
      devise_scope :user do  
    get '/users/sign_out' => 'devise/sessions#destroy'     
  end
  root to: "home#index"
end