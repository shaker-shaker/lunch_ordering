require "rails_helper"

RSpec.describe Order, type: :model do
  it { should validate_presence_of(:user_id) }

  let(:dish1) { create :dish }
  let(:dish2) { create :dish, category_id: dish1.category.id }
  let(:order) { build :order }

  describe "creation" do
    context "without order items" do
      it "is not allowed" do
        expect(order).not_to be_valid
      end
    end

    context "with order items" do
      before { order.items << dish1 }

      it "is allowed" do
        expect(order).to be_valid
      end
    end

    context "with 2 items from same category" do
      before { order.items << [dish1, dish2] }

      it "is not allowed" do
        expect(order).to be_valid
      end
    end
  end
end
