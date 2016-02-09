FactoryGirl.define do
  factory :user, class: User do
    sequence(:name)  { |n| "Person #{n}" }
    sequence(:email) { |n| "person_#{n}@example.com"}
    password "foobar123"
    password_confirmation "foobar123"
    role_id 2
  end

  factory :admin, class: User do
    admin true
    name     "Example Admin"
    email    "user@admin.com"
    password "foobar123"
    password_confirmation "foobar123"
    role_id 1
  end

end