Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  root to: 'foods#index'
  resources :foods, only: %i[index show new create destroy]
  resources :recipes_foods, only: %i[show create destroy]
  
  resources :recipes, only: [:index, :new, :create, :show, :destroy] do
    member do
      patch :public_toggle
    end
  end

  resources :public_recipes, only: %i[index]

  get '/shopping_list', to: 'recipes#shopping_list', as: 'shopping_list'
end
