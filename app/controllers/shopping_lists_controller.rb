class ShoppingListsController < ApplicationController
  def index
    @recipe = Recipe.find(params[:recipe_id])
    @recipe_food = @recipe.recipe_foods.group(:food_id).sum(:quantity)
    @foods = current_user.foods
    @shopping = []
    @foods.each do |food|
      @shopping << food if !@recipe_food.key?(food.id) && !@shopping.include?(food)
    end
    @total_price = @shopping.sum(&:price)
    @total_item = @shopping.count
  end
end
