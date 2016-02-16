require 'rails_helper'

RSpec.describe User, type: :model do
	before do
		@user = User.new(name: "Example User", email: "user@example.com",
			password: "foobar123", password_confirmation: "foobar123")
	end

	subject { @user }

	it { should respond_to(:name) }
	it { is_expected.to respond_to(:api_token) }
	it { should be_valid }

	context "with invalid data" do
		before { @user.name = "" }
		it {is_expected.not_to be_valid}
	end

	context "after saving" do 
		before { @user.save }

		describe "first user" do
			it { expect(@user.reload).to be_admin }
		end

		describe "second user" do
			subject(:user2) { User.create(name: "Example User2", email: "random@user2.com",
				password: "foobar123", password_confirmation: "foobar123") }
			it { should_not be_admin }
		end
	end

	describe "when user has order" do
		let!(:user) {FactoryGirl.create(:user)}
		let!(:order) {FactoryGirl.create(:order, user_id: user.id)}

		describe "after its deleting" do
			before do
				user.destroy
				it "corresponding order should be deleted too" do
					expect(User.count).to eq 0
					expect(Order.count).to eq 0
				end
			end
		end
	end
end
