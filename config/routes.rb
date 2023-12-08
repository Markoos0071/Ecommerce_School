Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  resources :products, only: [:index, :show] do
    member do
      post 'add_to_cart'
      delete 'remove_from_cart'
    end
    collection do
      get 'cart'
    end
  end

  resources :categories, only: [:index, :show]

  root to: 'products#index'
end
