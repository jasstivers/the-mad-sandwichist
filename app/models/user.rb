class User < ApplicationRecord
  has_merit
  has_many :sandwiches


  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  acts_as_favoritor
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def has_badge?(badge_name)
    badges.any? { |badge| badge.name == badge_name }
  end
end
