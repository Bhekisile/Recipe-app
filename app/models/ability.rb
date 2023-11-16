# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    can :public_recipes, Recipe
    can :read, Recipe, public: true
    return unless user.present?

    can :manage, Recipe, user_id: user.id
  end
end