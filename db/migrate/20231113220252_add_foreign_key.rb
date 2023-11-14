class AddForeignKey < ActiveRecord::Migration[7.1]
  def change
    add_foreign_key :food, :user, column: :user_id
    add_foreign_key :recipe_food, :recipe, column: :recipe_id
  end
end
