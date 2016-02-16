require 'rails_helper'

RSpec.describe Api::V1::ApiController, :type => :controller do
  render_views 

  let(:user) { FactoryGirl.create(:user) }
  let(:dish) { FactoryGirl.create(:dish) }
  let(:order) { FactoryGirl.build(:order, user_id: user.id) }

  before do
    order.dishes << dish
    order.save
  end
  context "with valid token" do
    before do
      get :today_orders, token: user.api_token
    end

    it "should response with information in json format" do
      json_response = ActiveSupport::JSON.decode response.body
      expect(json_response["orders"][0]["user"]["name"]).to eq user.name 
      expect(json_response["orders"][0]["dishes"][0]["name"]).to eq dish.name
      expect(json_response["orders"][0]["total"]).to eq dish.price 
    end
  end

  context "with invalid token" do
    before do
      get :today_orders, token: "invalidTOKEN"
    end

    it "should error in json format" do
      json_response = ActiveSupport::JSON.decode response.body
      expect(json_response["error"]["message"]).to eq "Invalid token"
    end
  end
end