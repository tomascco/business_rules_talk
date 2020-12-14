Rails.application.routes.draw do
  root 'products#index'
  
  resources :products, only: :index
  resource :cart, only: :show
  resources :cart_products, only: [:create, :update, :destroy]
end
