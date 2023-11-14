require 'rails_helper'

RSpec.describe 'Food', type: :request do
  let(:food) { Food.create(name: 'apple', measurement_unit: 'grams', price: 5) }
  # before { food.save }

  it 'has many Recipe-foods' do
    food = Food.reflect_on_association(:recipe_foods)
    expect(food.macro).to eq :has_many
  end
end