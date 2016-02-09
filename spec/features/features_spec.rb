require "rails_helper"

RSpec.feature "Page title", :type => :feature do
	scenario "at sign in path" do
		visit new_user_session_path
		expect(page).to have_title("Lunch Ordering | Log in")
	end

	scenario "at sign in path" do
		visit root_path
		expect(page).to have_title("Lunch Ordering")
	end
end

RSpec.feature "Sign in", :type => :feature do
	let(:user) { FactoryGirl.create(:user) }
	before do
		visit new_user_session_path
		fill_in "Email",	:with => user.email
		fill_in "Password",	:with => user.password
	end

	scenario "with valid fields" do
		click_button "Log in"
		current_url.should eq root_url
		expect(page.body).to have_text "You signed in as #{user.name}"
	end

	scenario "with invalid fields" do
		fill_in "Email",	:with => ""
		fill_in "Password",	:with => ""
		click_button "Log in"
		expect(page.body).to have_css "div.alert.alert-danger", :text => 'Invalid email or password.'
	end
end

RSpec.feature "Sign up", :type => :feature do
	let(:user) { FactoryGirl.build(:user) }
	before do
		visit new_user_registration_path
		fill_in "Name", 	:with => user.name
		fill_in "Email",	:with => user.email
		fill_in "Password",	:with => user.password
		fill_in "Password confirmation", :with => user.password_confirmation
	end

	scenario "with valid fields" do
		expect { click_button "Sign up" }.to change(User, :count).by(1)
		current_url.should eq root_url
	end

	scenario "with invalid fields" do
		fill_in "Name", 	:with => ""
		expect { click_button "Sign up" }.not_to change(User, :count)
	end
end

RSpec.feature "Edit profile", :type => :feature do
	let(:user) { FactoryGirl.create(:user) }
	before do
		login_as(user, :scope => :user)
		visit edit_user_path(user)
	end

	scenario "with valid fields" do
		fill_in "Name", 	:with => "newname"
		expect { click_button "Update" }.to change{ user.reload.name }.to("newname")
	end

	scenario "with invalid fields" do
		fill_in "Name", 	:with => ""
		expect { click_button "Update" }.not_to change{ user.reload.name }
		expect(page.body).to have_css "div.alert.alert-danger"
	end
end