class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
  has_many :recipes, foreign_key: 'user_id'
  has_many :recipe_foods, through: :recipes
  has_many :foods

  validates :name, presence:

  def default_recipe
    recipes.first
  end
end
