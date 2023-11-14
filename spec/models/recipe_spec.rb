require 'rails_helper'

RSpec.describe Recipe, type: :model do
  describe 'associations' do
    it 'belongs to a user' do
      # Assuming you have a User model
      user = User.create(name: 'John Doe')
      recipe = Recipe.new(name: 'Sample Recipe', user: user)

      expect(recipe.user).to eq(user)
    end

    it 'has many foods through recipe_foods' do
      # Assuming you have a Food model
      food1 = Food.create(name: 'Ingredient 1', measurement_unit: 'grams', price: 2)
      food2 = Food.create(name: 'Ingredient 2', measurement_unit: 'grams', price: 3)

      recipe = Recipe.new(name: 'Sample Recipe')
      recipe.foods << food1
      recipe.foods << food2

      expect(recipe.foods).to include(food1, food2)
    end
  end

  describe 'validations' do
    it 'is not valid without a name' do
      recipe = Recipe.new(name: nil)
      expect(recipe).not_to be_valid
    end

    it 'ensures the length of name is at most 255 characters' do
      recipe = Recipe.new(name: 'a' * 256)
      expect(recipe).not_to be_valid
    end

    it 'ensures preparation time is greater than or equal to 0' do
      recipe = Recipe.new(preparation_time: -1)
      expect(recipe).not_to be_valid
    end

    it 'ensures cooking time is greater than or equal to 0' do
      recipe = Recipe.new(cooking_time: -1)
      expect(recipe).not_to be_valid
    end

    it 'ensures the length of description is at most 2000 characters' do
      recipe = Recipe.new(description: 'a' * 2001)
      expect(recipe).not_to be_valid
    end
  end
end
