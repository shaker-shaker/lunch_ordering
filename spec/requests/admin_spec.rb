require 'rails_helper'

RSpec.describe "Request to", type: :request do
	let!(:admin) { FactoryGirl.create(:user) }
  let!(:user) { FactoryGirl.create(:user) }

  describe "order history" do
    describe "for a customer" do 
      before do
        sign_in user
        xhr :get, orders_history_path({date: "1/12/2015"}), format: 'js'
      end

      it "should be not accessible" do
        expect(response).to redirect_to root_path
      end
    end

    describe "for admin" do 
      before do
        sign_in admin
        xhr :get, orders_history_path({date: "1/12/2015"}), format: 'js'
      end

      it "should be accessible" do
        expect(response.code).to eq "200"
      end
    end
  end

  describe "menu edit" do
    describe "for a customer" do 
      before do
        sign_in user
        xhr :post, dishes_path({ "dish_category" => { "id"=>"1" },
                                 "name" => "2", "price" => "2" }),
            format: 'js'
      end

      it "should be not accessible" do
        expect(response).to redirect_to root_path
      end
    end

    describe "for admin" do 
      before do
        sign_in admin
        xhr :post, dishes_path({ "dish_category" => { "id" => "1" },
                                 "name" => "2", "price" => "2" }),
            format: 'js'
      end

      it "should be accessible" do
        expect(response.code).to eq "200"
      end
    end
  end

  describe "users list" do
    describe "for a customer" do 
      before do
        sign_in user
        xhr :post, dishes_path({ "dish_category" => { "id" => "1" },
                                 "name" => "2", "price" => "2" }),
            format: 'js'
      end

      it "should be not accessible" do
        expect(response).to redirect_to root_path
      end
    end

    describe "for admin" do 
      before do
        sign_in admin
        xhr :post, dishes_path({ "dish_category" => { "id" => "1" },
                                 "name" => "2", "price" => "2" }),
            format: 'js'
      end

      it "should be accessible" do
        expect(response.code).to eq "200"
      end
    end
  end

end
