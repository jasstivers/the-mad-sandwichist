class Review < ApplicationRecord
  belongs_to :sandwich

  validates :username, presence: true
  validates :review_text, presence: true
  validates :star_rating, presence: true
  validates :crazy_rating, presence: true
end
