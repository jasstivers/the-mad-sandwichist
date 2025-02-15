class Sandwich < ApplicationRecord
  belongs_to :user
  acts_as_favoritable

  has_many :sandwich_ingredients
  has_many :ingredients, through: :sandwich_ingredients

  validates :name, presence: true
  has_one_attached :photo
end
