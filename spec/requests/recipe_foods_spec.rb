require 'rails_helper'

RSpec.describe 'Recipe_food', type: :request do
  Devise::Test::IntegrationHelpers
  before do
    Rails.application.routes.default_url_options[:host] = 'localhost:3000'
    sign_in user
  end
  
  let(:user) { User.create!(name: 'Joy', email: 'test@example.com', password: 'password') }
  let(:recipe) { Recipe.create(name: 'food', preparation_time: 1, cooking_time: 1.5, description: 'steps to go', public: false, user_id: user.id) }
  let(:food) { Food.create(name: 'apple', measurement_unit: 'grams', price: 5) }
  let(:recipe_food) { RecipeFood.create(quantity: 20, recipe_id: recipe.id, food_id: food.id) }

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new Recipe' do
        expect do
          post recipe_foods_path, params: { recipe_food: { quantity: 3, food_id: food.id, recipe_id: recipe.id } }
        end.to change(Recipe, :count).by(1)
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the requested recipe' do
      expect do
        delete recipe_path(recipe)
      end.to change(Recipe, :count).by(1)
    end
  end
end
