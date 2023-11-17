class AddForeignKey < ActiveRecord::Migration[7.1]
  def change
    add_foreign_key :recipe_foods, :recipes, column: :recipe_id
  end
end
