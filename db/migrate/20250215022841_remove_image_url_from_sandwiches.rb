class RemoveImageUrlFromSandwiches < ActiveRecord::Migration[7.1]
  def change
    remove_column :sandwiches, :image_url, :string
  end
end
