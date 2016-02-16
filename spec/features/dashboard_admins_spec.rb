require 'rails_helper'

RSpec.feature "Dashboard", type: :feature do
  let!(:admin) { FactoryGirl.create(:user) }
  let!(:user) { FactoryGirl.create(:user) }

  describe "for admin", :js => true do
    before(:each) do 
      login_as(admin, :scope => :user)
    end

    subject { page }

    describe "on order history tab" do
      before do
        Order.new(user: user).save(:validate => false)
        yesterday_order = Order.new(user: user)
        yesterday_order.save(:validate => false)
        yesterday_order.created_at = Date.yesterday
        yesterday_order.save(:validate => false)
        visit dashboard_path 
        click_link "Order history"
        select_date Date.yesterday
      end

      it "history should be visible" do
        is_expected.to have_css "#today-orders td", text: user.name
        is_expected.to have_css "#orders-history td", text: user.name
      end
    end

    describe "on menu edit tab" do
      before do
        visit dashboard_path 
        click_link "Edit today's menu"
      end

      describe "while posting new dish" do
        context "with icnorrect data" do
          it "should not create dish" do
            expect { 
              page.find("input[type=submit][value='Submit']").click
              wait_for_ajax
               }.to_not change{ Dish.count }
            is_expected.to have_css ".alert.alert-danger" 
          end
        end

        context "with correct data" do
          before do 
            fill_in "Name", with: "test dish"
            fill_in "Price", with: "123"
            select "first course", :from => "#{}dish_category_id"
          end

          specify "new dish should be created" do 
            expect { 
              page.find("input[type=submit][value='Submit']").click
              wait_for_ajax
               }.to change{ Dish.count }.by(1)
            is_expected.to have_css ".alert.alert-success" 
            is_expected.to have_css ".dish-name", text: "test dish"
          end
        end
      end
    end

    describe "on user list tab" do
      before do
        visit dashboard_path 
        click_link "Registered users"
      end

      it {is_expected.to have_css ".tab-pane.active td", text: user.name}
      
    end

  end
end
