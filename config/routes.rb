Rails.application.routes.draw do
  devise_for :users

  root "static_pages#home"

  resources :businesses do
    resources :products
    resources :stores
    resources :customers do
      resources :product_item_dates, except: [:index, :show]
    end
  end
  
  get '/dashboard', to: 'static_pages#dashboard'
  get '/pricing', to: 'static_pages#pricing'
end
