require 'rails_helper'

RSpec.describe 'Recipe_food', type: :request do
  before do
    Rails.application.routes.default_url_options[:host] = 'localhost:3000'
  end
  
  let(:user) { User.create!(name: 'Joy', email: 'test@example.com', password: 'password') }
  let(:recipe) { Recipe.create(name: 'food', preparation_time: 1, cooking_time: 1.5, description: 'steps to go', public: false, user_id: user.id) }
  let(:food) { Food.create(name: 'apple', measurement_unit: 'grams', price: 5) }
  let(:recipe_food) { RecipeFood.create(quantity: 20, recipe_id: recipe.id, food_id: food.id) }

  it 'without belongs_to associations, it should be invalid' do
    recipe_food.food = nil
    expect(recipe_food).not_to be_valid
  end

  describe 'Validation' do
    it 'quantity should be present' do
      recipe_food.quantity = nil
      expect(recipe_food).to_not be_valid
    end
  end
end
