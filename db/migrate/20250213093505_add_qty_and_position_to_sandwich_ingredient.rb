class AddQtyAndPositionToSandwichIngredient < ActiveRecord::Migration[7.1]
  def change
    add_column :sandwich_ingredients, :ingredient_qty, :float
    add_column :sandwich_ingredients, :ingredient_position, :integer
  end
end
