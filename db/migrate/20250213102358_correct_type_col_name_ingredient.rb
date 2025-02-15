class CorrectTypeColNameIngredient < ActiveRecord::Migration[7.1]
  def change
    rename_column :ingredients, :type, :ingr_type
  end
end
