FactoryGirl.define do
  factory :dish_category, class: DishCategory do
    sequence(:name) { |n| "dish category #{n}" }
  end
end
