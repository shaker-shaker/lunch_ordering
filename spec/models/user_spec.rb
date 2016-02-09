require 'rails_helper'

RSpec.describe User, type: :model do
	before do
		@user = User.new(name: "Example User", email: "user@example.com",
			password: "foobar123", password_confirmation: "foobar123")
		['lunch admin', 'customer'].each do |role|
			Role.find_or_create_by({name: role})
		end
	end

	subject { @user }

	it { should respond_to(:name) }
	it { should be_valid }

	context "after saving" do 
		before { @user.save }

		describe "first user" do
			it { should be_admin }
		end

		describe "second user" do
			subject(:user2) { User.create(name: "Example User2", email: "user2@example.com",
				password: "foobar123", password_confirmation: "foobar123") }
			it { should_not be_admin }
		end
	end
end
