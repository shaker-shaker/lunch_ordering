require "rails_helper"

RSpec.describe OrdersController, type: :controller do
  let!(:admin) { create :user }
  let!(:user) { create :user }
  let(:dish) { create :dish }

  describe "#history" do
    context "by not authenticated user" do
      before { get :history }

      it "is not allowed" do
        expect(response).to redirect_to(user_session_path)
      end
    end

    context "by user with non-admin role" do
      before do
        sign_in user
        get :history
      end

      it "is not allowed" do
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe "#create" do
    context "by not authenticated user" do
      before { post :create }

      it "is not allowed" do
        expect(response).to redirect_to(user_session_path)
      end
    end

    context "by authenticated" do
      before { sign_in admin }
      let(:params) do
        {
          selected_dishes: {
            dish.id.to_s => dish.id.to_s,
          },
        }
      end

      it "is allowed" do
        expect { post :create, order: params }.to change { Order.count }.by(1)
        expect(response).to redirect_to new_order_path("menu-date" => Date.today)
      end
    end
  end
end
