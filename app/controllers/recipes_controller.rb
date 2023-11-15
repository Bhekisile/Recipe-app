class RecipesController < ApplicationController
    def index
        @recipes = Recipe.all
    end

    def create
        # @recipe = Recipe.new(recipe_params) -- for devise

       # Ensure that a user is associated with the recipe
        if user_signed_in?
            @recipe = current_user.recipes.new(recipe_params)
        else
        # If user is not logged in, set a default user (you may need to adjust this logic)
        @recipe = Recipe.new(recipe_params)
        @recipe.user = User.find_by(email: 'default@example.com') # Replace with an existing user or create a default user
      end
    
        if @recipe.save
          redirect_to @recipe, notice: 'Recipe was successfully created.'
        else
          render :new
        end
      end

    def show; end

    def new
        @recipe = Recipe.new
    end

    def edit; end


  private

  def recipe_params
    params.require(:recipe).permit(:name, :preparation_time, :cooking_time, :description, :public)
  end

end
