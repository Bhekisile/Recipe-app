class AddForeignKey < ActiveRecord::Migration[7.1]
  def change
    AddForeignKey :food, :user, column: :user_id
    AddForeignKey :recipe_food, :recipe, column: :recipe_id
  end
end
