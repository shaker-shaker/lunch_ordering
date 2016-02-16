namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    #make_users
    make_dishes
    #make_orders
  end
end

def make_users
  User.create!(
   name: Faker::Name.name,
   email: "example@example.com",
   password: "123123123",
   password_confirmation: "123123123")
  99.times do |n|
    name  = Faker::Name.name
    email = "example-#{n+1}@example.com"
    password  = "123123123"
    User.create!(name: name,
     email: email,
     password: password,
     password_confirmation: password)
  end
end

def make_dishes
  categories = DishCategory.all.to_a
  prng = Random.new
  (50.days.ago.to_datetime..50.days.since.to_datetime).each do |date|
    unless date.sunday? || date.saturday?
      categories.each do |category|
        dish_count = prng.rand(3..5)
        (1..dish_count).each do |i|
         name = Faker::Hipster.word
         price = prng.rand(5.0..200.0)
         Dish.create(name: name, date: date, category: category, price: price)
       end
     end
   end
 end
 
end

def make_orders

end