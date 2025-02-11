class Sandwich < ApplicationRecord
  belongs_to :user

  has_many :sandwich_ingredients
  has_many :ingredients, through: :sandwich_ingredients

  validates :name, presence: true
end
