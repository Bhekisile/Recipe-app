require 'rails_helper'

RSpec.describe 'RecipesFoods', type: :request do
  let(:user) { User.create(name: 'Joy', email: 'test@example.com') }
  let(:recipe) { Recipe.create(name: 'food', preparation_time: 20, cooking_time: 10, description: 'this is how', public: false, user: user) }
  let(:id) { RecipeFood.create(quantity: 20, recipe_id:, food_id:) }.id
  let(:id) { RecipeFood.create(quantity: 20, recipe_id: recipe.id, food_id: some_food_id).id }

  describe 'GET /recipes/:recipe_id/recipes_foods/id' do
    before :each do
      sign_in user
      get recipe_recipes_food_path(recipe_id: recipe, id)
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'should render the correct template' do
      expect(response).to render_template(:new)
    end
  end
end
