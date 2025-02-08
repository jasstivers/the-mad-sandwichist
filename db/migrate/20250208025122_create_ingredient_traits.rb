class CreateIngredientTraits < ActiveRecord::Migration[7.1]
  def change
    create_table :ingredient_traits do |t|
      t.references :ingredient, null: false, foreign_key: true
      t.references :trait, null: false, foreign_key: true

      t.timestamps
    end
  end
end
