Rails.application.routes.draw do
  devise_for :users
  get '/dashboard', to: 'static_pages#dashboard'
  get '/pricing', to: 'static_pages#pricing'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  root "static_pages#home"
end
