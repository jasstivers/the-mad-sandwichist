class CorrectTypeColNameTrait < ActiveRecord::Migration[7.1]
  def change
    rename_column :traits, :type, :trait_type
  end
end
