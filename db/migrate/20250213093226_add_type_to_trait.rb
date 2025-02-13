class AddTypeToTrait < ActiveRecord::Migration[7.1]
  def change
    add_column :traits, :type, :string
  end
end
