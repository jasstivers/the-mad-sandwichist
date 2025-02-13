class AddTypeToIngredient < ActiveRecord::Migration[7.1]
  def change
    add_column :ingredients, :type, :string
  end
end
