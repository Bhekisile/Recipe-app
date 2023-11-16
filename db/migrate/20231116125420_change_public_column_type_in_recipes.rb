class ChangePublicColumnTypeInRecipes < ActiveRecord::Migration[7.1]
  def change
    change_column :recipes, :public, :boolean, using: 'public::boolean'
  end
end
