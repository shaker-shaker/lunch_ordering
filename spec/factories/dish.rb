FactoryGirl.define do
  factory :dish, class: Dish do
    sequence(:name) { |n| "dish_name_#{n}" }
    price Random.new.rand(5.0..200.0)
    association :category, factory: :dish_category
    created_at Time.zone.now
  end
end
