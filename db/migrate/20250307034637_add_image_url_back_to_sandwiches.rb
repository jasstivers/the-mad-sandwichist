class AddImageUrlBackToSandwiches < ActiveRecord::Migration[7.1]
  def change
    add_column :sandwiches, :image_url, :string
  end
end
