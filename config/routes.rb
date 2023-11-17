Rails.application.routes.draw do
  devise_for :users
  get "up" => "rails/health#show", as: :rails_health_check

  root to: 'foods#index'
  get '/shopping_list', to: 'recipes#shopping_list', as: 'shopping_list'
  
  resources :foods, only: %i[index show new create destroy]
  resources :recipe_foods, only: %i[new show create destroy]
  
  resources :recipes, only: [:index, :new, :create, :show, :destroy] do
    member do
      patch :public_toggle
    end
  end

  resources :public_recipes, only: %i[index]

  resources :shopping_lists, only: [:index]
end
