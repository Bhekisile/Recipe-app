class CreateRecipeFoods < ActiveRecord::Migration[7.1]
  def change
    create_table :recipe_foods do |t|
      t.integer :quantity, default: 0
      t.integer :recipe_id
      t.references :food, null: false, foreign_key: true

      t.timestamps
    end
  end
end
