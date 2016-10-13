OCms::Engine.routes.draw do

  root to: 'dashboard#index'
  resources :images
  resources :posts
  resources :categories
end
