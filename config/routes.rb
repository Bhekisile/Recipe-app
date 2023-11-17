Rails.application.routes.draw do
  devise_for :users
  get "up" => "rails/health#show", as: :rails_health_check

  root to: 'foods#index'
  get '/shopping_list', to: 'recipes#shopping_list', as: 'shopping_list'
  
  resources :foods, only: %i[index show new create destroy]
  resources :recipes_foods, only: %i[show create destroy]
  
  resources :recipes do
    member do
      patch :public_toggle
      patch :update_public_status
      patch :destroy, to: 'recipes#destroy'
    end
  
    resources :recipe_foods, only: [:index, :new, :create, :edit, :update, :destroy]
  end
  

  get '/public_recipes', to: 'recipes#public_recipes', as: 'public_recipes'

end
