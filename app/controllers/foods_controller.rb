class FoodsController < ApplicationController
  def index
    @foods = current_user.foods
  end

  def show
    @food = Food.find(params[:id])
  end

  def new
    @food = Food.new
  end

  def create
    @food = current_user.foods.build(food_params)

    if @food.save
      flash[:notice] = 'Food was successfully created.'
      # Do not create a shopping list item here
      redirect_to foods_path(@food)
    else
      flash[:alert] = 'Food was not created.'
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @food = Food.find(params[:id])

    # Remove the food from the shopping list when it is destroyed
    current_user.shopping_list_items.where(food: @food).destroy_all

    @food.destroy
    flash[:notice] = 'Food was successfully destroyed.'
    redirect_to foods_url
  end

  private

  def food_params
    params.require(:food).permit(:name, :measurement_unit, :price, :quantity)
  end
end
