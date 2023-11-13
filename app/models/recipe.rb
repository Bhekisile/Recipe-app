class Recipe < ApplicationRecord
  validates :name, presence: true, length: { maximum: 250 }
  validates :description, length: { maximum: 2000 }
  validates :preparation_time, numericality: { greater_than_or_equal_to: 0 }
  validates :cooking_time, numericality: { greater_than_or_equal_to: 0 }

  belongs_to :user
  has_many :recipe_foods
end
