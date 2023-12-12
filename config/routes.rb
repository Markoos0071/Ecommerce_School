Rails.application.routes.draw do
  get 'orders/index'
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  resources :products, only: [:index, :show] do
    member do
      post 'add_to_cart'
      patch 'update_cart'
      delete 'remove_from_cart'
    end
    collection do
      get 'cart'
      get 'checkout'
      post 'checkout'
    end
  end

  resources :categories, only: [:index, :show]
  resources :orders, only: [:index]

  devise_for :users
  root to: 'products#index'
end
