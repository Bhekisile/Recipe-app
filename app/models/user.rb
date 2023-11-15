class User < ApplicationRecord
  has_many :recipes, foreign_key: 'user_id'
  has_many :foods

  validates :name, presence: true
end
