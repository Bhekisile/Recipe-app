class RecipesController < ApplicationController
  before_action :set_recipe, only: %i[show edit destroy]

  def index
    @recipes = Recipe.all
  end

  def create
    @recipe = current_user.recipes.new(recipe_params)

    if @recipe.save
      add_to_public_recipes if @recipe.public?
      redirect_to recipes_path, notice: 'Recipe was successfully created.'
    else
      render :new
    end
  end

  def shopping_list
    # Use current_user's recipe or any other logic to determine which recipe to show
    @recipe = current_user.recipes.last

    # Ensure that a recipe is available before proceeding
    if @recipe.present?
      @recipe_foods = @recipe.recipe_foods.includes(:food)
      @all_foods = Food.all # Or use your logic to fetch all foods
      @shopping = @all_foods - @recipe_foods.map(&:food)
    else
      redirect_to recipes_path, alert: 'No recipe found.'
    end
  end

  def show
    @recipe_food = @recipe.recipe_foods.includes(:food)
  end

  def new
    @recipe = Recipe.new
  end

  def edit
    authorize_user
  end

  def destroy
    authorize_user
    @recipe.destroy
    redirect_to recipes_path, notice: 'Recipe was successfully deleted.'
  end

  private

  def set_recipe
    @recipe = Recipe.find(params[:id])
  end

  def recipe_params
    params.require(:recipe).permit(:name, :preparation_time, :cooking_time, :description, :public)
  end

  def authorize_user
    return if current_user == @recipe.user

    redirect_to recipes_path,
                alert: 'You are not authorized to perform this action.'
  end

  def add_to_public_recipes
    @recipe.update(public: true)
  end
end
