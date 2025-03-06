class Sandwich < ApplicationRecord
  belongs_to :user
  acts_as_favoritable

  has_many :sandwich_ingredients
  has_many :ingredients, through: :sandwich_ingredients

  validates :name, presence: true
  has_one_attached :photo

  has_many :reviews, dependent: :destroy
  def average_crazyness
    reviews.average(:crazy_rating)&.round.to_i || 0
  end

  def average_starness
    reviews.average(:star_rating)&.round.to_i || 0
  end

end
