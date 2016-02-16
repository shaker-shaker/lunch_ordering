FactoryGirl.define do
  factory :user, class: User do
    sequence(:name)  { |n| "Person #{n}" }
    sequence(:email) { |n| "person_#{n}@example.com"}
    password "foobar123"
    password_confirmation "foobar123"
  end

  factory :dish, class: Dish do
    sequence(:name)  { |n| "Dish #{n}" }
    price    Random.new.rand(5.0..200.0)
    category_id 1 
    after(:build) do |obj|
      unless obj.date.present?
        weekday = Date.new(Date.today.year, Date.today.month, 1)
        while weekday.wday == 0 || weekday.wday == 6 do 
          weekday += 1 
        end
        obj.date = weekday
      end
    end
  end

  factory :order, class: Order do
    user_id 1
  end
end