class ShoppingListController < ApplicationController
  def index
    @recipe_food = current_user.recipe_foods.group(:food_id).sum(:quantity)
    @foods = current_user.foods
    @shopping = []
    @foods.each do |food|
      @shopping << food if !@recipe_food.key?(food.id) && !@shopping.include?(food)
    end
    @total_price = @shopping.sum(&:price)
    @total_item = @shopping.count
  end
end
