class CreateFoods < ActiveRecord::Migration[7.1]
  def change
    create_table :foods do |t|
      t.string :name
      t.string :measurement_unit
      t.integer :price
      t.integer :quantity, default: 0
      t.integer :user_id

      t.timestamps
    end
  end
end
