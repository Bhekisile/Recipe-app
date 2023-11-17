class RecipesController < ApplicationController
  def index
    @recipes = Recipe.all
  end

  def create
    # Ensure that a user is associated with the recipe
    if user_signed_in?
      @recipe = current_user.recipes.new(recipe_params)
    else
      # If user is not logged in, set a default user (you may need to adjust this logic)
      @recipe = Recipe.new(recipe_params)
      @recipe.user = User.find_by(email: 'default@example.com') # Replace with an existing user or create a default user
    end

    # Set the public attribute based on the checkbox value
    @recipe.public = params[:recipe][:public] == '1'

    if @recipe.save
      redirect_to @recipe, notice: 'Recipe was successfully created.'
    else
      render :new
    end
  end

  def show
    @recipe = Recipe.find(params[:id])
    @recipe_foods = @recipe.recipe_foods
  end

  def new
    @recipe = Recipe.new
  end

  def public_recipes
    @public_recipes = Recipe.where(public: true).order(created_at: :desc)
  end

  def update_public_status
    @recipe = Recipe.find(params[:id])
    @recipe.update(public: !@recipe.public)
    redirect_to recipe_path(@recipe), notice: 'Recipe status updated successfully.'
  end

  def shopping_list
    puts "Params: #{params.inspect}" # Add this line for debugging
    @recipe = Recipe.find(params[:id])
    @recipe_food = @recipe.recipe_foods.group(:food_id).sum(:quantity)
    @foods = current_user.foods
    @shopping = []

    @foods.each do |food|
      @shopping << food if !@recipe_food.key?(food.id) && !@shopping.include?(food)
    end

    # Ensure @shopping is initialized even if empty
    @shopping ||= []

    @total_price = @shopping.sum(&:price)
    @total_item = @shopping.count
  end

  def edit; end

  private

  def recipe_params
    params.require(:recipe).permit(:name, :preparation_time, :cooking_time, :description, :public)
  end
end
