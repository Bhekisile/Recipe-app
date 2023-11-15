class FoodsController < ApplicationController
  def index
    @foods = Food.all
  end

  def show
    @food = Food.find(params[:id])
  end

  def new
    @food = Food.new
  end

  def create
    @food = Food.new(food_params)
    if @food.save
      redirect_to recipes_path
    else
      render :new
    end
  end

  def destroy
    @food = Food.find(params[:id])

    if @food.user == current_user
      @food.destroy_all

      @food.destroy

      redirect_to food_path, notice: 'food deleted successfully.'
    else
      redirect_to food_path, alert: "You don't have a permission to delete this food."
    end
  end
end
