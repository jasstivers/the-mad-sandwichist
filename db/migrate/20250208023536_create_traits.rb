class CreateTraits < ActiveRecord::Migration[7.1]
  def change
    create_table :traits do |t|
      t.string :name

      t.timestamps
    end
  end
end
