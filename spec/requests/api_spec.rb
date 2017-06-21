require "rails_helper"

RSpec.describe Api::V1::ApiController, type: :controller do
  render_views

  let(:user) { create :user }
  let(:dish) { create :dish }
  let!(:order) { create(:order, user: user, items: [dish]) }

  context "with valid token" do
    before do
      request.env["HTTP_ACCEPT"] = "application/json"
      get :today_orders, token: user.api_token
    end

    it "responds with information in json format" do
      json_response = ActiveSupport::JSON.decode response.body
      expect(json_response["orders"][0]["user"]["name"]).to eq user.name
      expect(json_response["orders"][0]["items"][0]["name"]).to eq dish.name
      expect(json_response["orders"][0]["total"]).to eq dish.price.to_s
    end
  end

  context "with invalid token" do
    before do
      request.env["HTTP_ACCEPT"] = "application/json"
      get :today_orders, token: "invalidTOKEN"
    end

    it "responds error in json format" do
      json_response = ActiveSupport::JSON.decode response.body
      expect(json_response["message"]).to eq I18n.t("api.invalid_token")
    end
  end
end
