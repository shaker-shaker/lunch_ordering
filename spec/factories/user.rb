FactoryGirl.define do
  factory :user, class: User do
    sequence(:name)  { |n| "Person #{n}" }
    sequence(:email) { |n| "person_#{n}@example.com" }
    password "foobar123"
    password_confirmation "foobar123"
  end
end
