require 'rails_helper'

RSpec.describe 'Recipe_food', type: :request do
  # let(:user1) { User.create(name: 'Joy') }
  let(:recipe1) { Recipe.create(name: 'food', preparation_time: 1, cooking_time: 1.5, description: 'steps to go', public: false) }
  let(:food1) { Food.create(name: 'apple', measurement_unit: 'grams', price: 5) }
  let(:recipe_id) { recipe1.id }
  let(:food_id) { food1.id }
  let(:recipe_food1) { RecipeFood.create(quantity: 20, recipe_id:, food_id:) }

  it 'without belongs_to associations, it should be invalid' do
    recipe_food1.food = nil
    expect(recipe_food1).not_to be_valid
  end

  describe 'Validation' do
    it 'quantity should be present' do
      recipe_food1.quantity = nil
      expect(recipe_food1).to_not be_valid
    end
  end
end