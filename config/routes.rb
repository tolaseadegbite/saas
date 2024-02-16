Rails.application.routes.draw do
  devise_for :users
  get 'static_pages/home'
  get 'static_pages/pricing'
  get 'static_pages/dashboard'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  root "static_pages#home"
end
