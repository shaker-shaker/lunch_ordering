require 'rails_helper'

RSpec.feature "Dashboard page", type: :feature do
	let!(:admin) { FactoryGirl.create(:user) }
	let!(:user) { FactoryGirl.create(:user) }

	context "for a guest" do
		before { visit dashboard_path }
		it "should be not accessible" do
			expect(current_path).to eq new_user_session_path
		end
	end

	context "for customer." do
		before(:each) do 
			login_as(user, :scope => :user)
			visit dashboard_path 
		end

		subject { page }

		it { is_expected.to have_css "#day-selector" }
    it { is_expected.not_to have_css ".nav.nav-tabs" }

		context "while placing order", :js => true do
			let(:monday){ first_day_in_month(1) }
			let(:sunday){ first_day_in_month(0) }
			before(:each) do
				page.find('#day-selector').click 
			end 

			describe "Datepicker" do
				it "should appear" do
					is_expected.to have_css ".datepicker .datepicker-days table"
				end

				it "weekends should be disabled" do
					is_expected.to have_css ".datepicker .datepicker-days \
                                  table tr td.disabled", text: sunday.day.to_s
				end

				it "future days should be disabled" do
					is_expected.to have_css ".datepicker .datepicker-days \
                                  table tr td.disabled",
                                  text: (Date.today.day + 1).to_s
				end
			end

			describe "customer" do
				let!(:dish1) { FactoryGirl.create(:dish, date: monday) }
				let!(:dish2) { FactoryGirl.create(:dish, date: monday) }

				before do 
					within('.datepicker .datepicker-days') do
						first(:xpath, "//table//tr//td[text()='#{monday.day}' \
                          and contains(@class, 'day') \
                          and not(contains(@class, 'disabled'))]").click
					end
				end

				it "should see dishes for selected date" do
					is_expected.to have_css "span.dish-name", text: dish1.name  
          is_expected.to have_css "span.dish-name", text: dish2.name        
        end

        it "should see an error when he did't select any product" do
          expect do 
            page.find("input[type=submit][value='Submit']").click 
          end.to_not change { Order.count }
          is_expected.to have_css ".alert.alert-danger"   
        end

        describe "by clicking the product" do
          before do
            page.find(".dish-name", text: dish1.name).click
            wait_for_ajax
          end

          it "should see order total" do
            is_expected.to have_css(".order-total",
                                    text: dish1.price.round(2))
          end

          it "should be able to submit order" do
            expect do              
              page.find("input[type=submit][value='Submit']").click
              wait_for_ajax
            end.to change { Order.count }.by(1)
            is_expected.to have_css ".alert.alert-success"
            expect(Order.first.dishes).to include dish1
          end
        end
      end
    end
  end
end