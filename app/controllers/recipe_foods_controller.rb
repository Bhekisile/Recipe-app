class RecipeFoodsController < ApplicationController

  def new
    @recipe_food = RecipeFood.new
    @recipe_food.build_food
  end

  def create
    @recipe = Recipe.find(params[:recipe_id])
    food_id = recipe_food_params[:food_id]
    existing_food = @recipe.recipe_foods.find_by(food_id:)

    if existing_food
      update_existing_food(existing_food)
    else
      create_new_recipe_food
    end
  end

  def destroy
    @recipe_food = RecipeFood.find(params[:id])
    @recipe = @recipe_food.recipe

    update_recipe_totals_on_delete

    @recipe_food.destroy
    redirect_to recipe_path(@recipe), notice: 'RecipeFood deleted successfully!'
  end

  private

  def update_existing_food(existing_food)
    existing_food.quantity += recipe_food_params[:quantity].to_i

    if existing_food.save
      redirect_to recipe_path(@recipe), notice: 'Food quantity updated successfully.'
    else
      redirect_to recipe_path(@recipe), alert: 'Failed to update food quantity.'
    end
  end

  def create_new_recipe_food
    @recipe_food = RecipeFood.new(recipe_food_params)
    @recipe_food.recipe = @recipe

    if @recipe_food.save
      update_recipe_totals_on_create
      redirect_to recipe_path(@recipe), notice: 'RecipeFood was successfully created'
    else
      render :new, alert: 'Something went wrong'
    end
  end

  def update_recipe_totals_on_create
    @recipe.increment!(:foodcounter)
  end

  def update_recipe_totals_on_delete
    amount = @recipe.totalvaluecounter - @recipe_food.totalvalue
    @recipe.update(totalvaluecounter: amount)
    @recipe.decrement!(:foodcounter)
  end
end
