require "rails_helper"

RSpec.describe User, type: :model do
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:name) }

  describe "after save" do
    let!(:user1) { create :user }
    let!(:user2) { create :user }

    it { expect(user1).to be_admin }
    it { expect(user2).not_to be_admin }
  end

  describe "when user has order" do
    let(:user) { create :user }
    let!(:order) { create :order, user_id: user.id, items: [create(:dish)] }

    it "after user deleting corresponding order should be deleted too" do
      expect { user.destroy }.to change { Order.count }.by(-1)
    end
  end
end
