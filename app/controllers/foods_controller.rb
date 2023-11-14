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

  def destroy; end
end
