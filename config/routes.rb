Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  root "static_pages#home"

  resources :businesses do
    resources :products
  end
  
  get '/dashboard', to: 'static_pages#dashboard'
  get '/pricing', to: 'static_pages#pricing'
end
