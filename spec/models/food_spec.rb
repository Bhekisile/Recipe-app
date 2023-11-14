require 'rails_helper'

RSpec.describe 'Food', type: :request do
  let(:food) { Food.create(name: 'apple', measurement_unit: 'grams', price: 5) }
  let(:user) { User.create(name: 'Joy') }

  it 'has many Recipe-foods' do
    food = Food.reflect_on_association(:recipe_foods)
    expect(food.macro).to eq :has_many
  end

  it 'belongs to user' do
    food = Food.reflect_on_association(:user)
    expect(food.macro).to eq(:belongs_to)
  end

  describe 'Validations' do
    it 'name should be present' do
      food.name = nil
      expect(food).to_not be_valid
    end

    it 'measurement_unit should be present' do
      food.measurement_unit = nil
      expect(food).to_not be_valid
    end

    it 'price should be present' do
      food.price = nil
      expect(food).to_not be_valid
    end
  end
end