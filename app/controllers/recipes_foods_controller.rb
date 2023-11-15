class RecipesFoodsController < ApplicationController
  def index
    @recipe_food = RecipeFood.new
    @recipe_food.build_food
  end

  def show
    
  end

  def create
    @recipe = Recipe.find(params[:recipe_id])
    food_id = recipe_food_params[:food_id]
    existing_food = @recipe.recipe_foods.find_by(food_id:)
    if existing_food
      existing_food.quantity += recipe_food_params[:quantity].to_i
      if existing_food.save
        redirect_to recipe_path(@recipe), notice: 'Food quantity updated successfully.'
      else
        redirect_to recipe_path(@recipe), alert: 'Failed to update food quantity.'
      end
    else
      @recipe_food = RecipeFood.new(recipe_food_params)
      @recipe_food.recipe = @recipe

      if @recipe_food.save
        redirect_to recipe_path(@recipe), notice: 'RecipeFood was successfully created'
      else
        render :new, alert: 'Something went wrong'
      end
    end
  end

  def destroy
    @recipe_food = RecipeFood.find(params[:id])
    @recipe = Recipe.find(params[:recipe_id])

    amount = @recipe.totalvaluecounter - @recipe_food.totalvalue
    @recipe.update(totalvaluecounter: amount)

    @recipe.decrement!(:foodcounter)

    @recipe_food.destroy
    redirect_to recipe_path(id: @recipe), notice: 'RecipeFood deleted successfully!'
  end

  private

  def recipe_food_params
    params.require(:recipe_food).permit(:quantity, :food_id, food_attributes: %i[name measurement_unit price])
  end
end
