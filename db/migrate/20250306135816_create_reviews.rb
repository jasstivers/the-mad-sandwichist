class CreateReviews < ActiveRecord::Migration[7.1]
  def change
    create_table :reviews do |t|
      t.string :username
      t.text :review_text
      t.integer :star_rating
      t.integer :crazy_rating
      t.integer :sandwich_id

      t.timestamps
    end
  end
end
