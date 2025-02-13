class AddUnitOfMeasureToIngredient < ActiveRecord::Migration[7.1]
  def change
    add_column :ingredients, :unit_of_measure, :string
  end
end
