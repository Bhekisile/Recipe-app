class Food < ApplicationRecord
  has_many :recipe_foods, foreign_key: :food_id
  belongs_to :user, class_name: 'User', foreign_key: :user_id

  validates :name, presence: true
  validates :measurement_unit, presence: true
  validates :price, presence: true
end
