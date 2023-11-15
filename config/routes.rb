Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # devise_for :users
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  root to: 'recipes#index'
  resources :foods, only: %i[index show new create destroy]

  resources :recipes, only: %i[index show new create destroy] do
    resources :recipes_foods, only: %i[show create destroy]
  end
  resources :public_recipes, only: %i[index]

  get '/shopping_list', to: 'recipes#shopping_list', as: 'shopping_list'

end
