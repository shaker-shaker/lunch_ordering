FactoryGirl.define do
  factory :order, class: Order do
    association :user, factory: :user
  end
end
