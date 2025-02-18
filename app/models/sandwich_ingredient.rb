class SandwichIngredient < ApplicationRecord
  belongs_to :sandwich
  belongs_to :ingredient

  acts_as_list  top_of_list: 0
end
