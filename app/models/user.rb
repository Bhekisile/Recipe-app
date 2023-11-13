class User < ApplicationRecord
  has_many :Recipes
  has_many :Foods

  validates :name, presence: true
end
