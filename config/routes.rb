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
  devise_scope :user do  
    get '/users/sign_out' => 'devise/sessions#destroy'     
 end
   # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root to: "home#index"
  # Defines the root path route ("/")
  # root "articles#index"
end
