class Trait < ApplicationRecord
  has_many :ingredient_traits
  has_many :ingredient, through: :ingredient_traits
end
