class Ingredient < ApplicationRecord
  has_many :ingredient_traits
  has_many :traits, through: :ingredient_traits

  has_many :sandwich_ingredients
  has_many :sandwiches, through: :sandwich_ingredients

  has_one_attached :photo

  validates :name, presence: true
end
