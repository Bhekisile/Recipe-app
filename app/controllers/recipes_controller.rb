class RecipesController < ApplicationController
  before_action :set_recipe, only: [:show, :edit, :destroy]

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
    redirect_to recipes_path, alert: "You are not authorized to perform this action." unless current_user == @recipe.user
  end

  def add_to_public_recipes
    @recipe.update(public: true)
  end
end
