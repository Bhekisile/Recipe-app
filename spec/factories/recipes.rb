# spec/factories/recipes.rb
FactoryBot.define do
  factory :recipe do
    sequence(:name) { |n| "Recipe #{n}" }
    preparation_time { 30 }
    cooking_time { 60 }
    sequence(:description) { |n| "Description #{n}" }

    # Define the association with the user
    user
  end
end
