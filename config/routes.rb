Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  # Routes for Recipes
  resources :recipes

  # Routes for Users
  resources :users, only: [:index]

  root to: 'recipes#index'
end
