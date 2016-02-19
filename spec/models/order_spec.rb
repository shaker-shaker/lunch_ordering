require 'rails_helper'

RSpec.describe Order, type: :model do
  let!(:user) { FactoryGirl.create(:user) }
  let!(:dish) { FactoryGirl.create(:dish) }
  before(:each) do 
    @order = Order.new(user: user) 
    @order.dishes << dish
  end

  subject { @order }

  context "with correct data" do
    it { is_expected.to be_valid }
  end

  context "with empty" do
    it "dishes" do
      @order.dishes.clear
      is_expected.not_to be_valid 
    end
  end
end
