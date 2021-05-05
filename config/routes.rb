Rails.application.routes.draw do
  devise_for :users
  devise_for :admins
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  # api/categories
  # api/categories/:category_id/products

  namespace :api do
    resources :sessions, only: [:create]
    
    resources :categories, only: [:index] do
      resources :products, only: [:index, :show]
    end

    resource :profile, only: [:show]
    resources :users , only: [:create]
    resources :cart_items, only: [:create, :index, :update, :destroy]
    resources :orders, only: [:index,:create, :show]
  end
end