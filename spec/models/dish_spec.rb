require 'rails_helper'

RSpec.describe Dish, type: :model do
  before(:each) { 
    date = Date.new(Date.today.year, Date.today.month, 1)
    while date.wday == 0 || date.wday == 6 do date += 1 end
    @dish = Dish.new(name: "dishname", price: "11.11",
   date: date, 
   category: DishCategory.first) }
  subject { @dish }

  context "with correct data" do
    it { is_expected.to be_valid }
  end

  context "with empty" do
    it "name" do
      @dish.name = nil
      is_expected.not_to be_valid 
    end
    it "price" do
      @dish.price = nil
      is_expected.not_to be_valid 
    end
    it "date" do
      @dish.date = nil
      is_expected.not_to be_valid 
    end
    it "category" do
      @dish.category = nil
      is_expected.not_to be_valid 
    end
  end

  context "with incorrect" do
    it "name" do
      @dish.name = "a"*100
      is_expected.not_to be_valid 
    end
    it "price" do
      @dish.price = "aaa"
      is_expected.not_to be_valid 
    end
    it "price" do
      @dish.price = -100
      is_expected.not_to be_valid 
    end
    it "date" do
      @dish.date = Date.tomorrow
      is_expected.not_to be_valid 
    end
    it "date" do
      @dish.date = Date.today - Date.today.wday
      is_expected.not_to be_valid 
    end
  end
end
