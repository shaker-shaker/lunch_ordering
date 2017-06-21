require "rails_helper"

RSpec.describe DishesController, type: :controller do
  let!(:admin) { create :user }
  let!(:user) { create :user }
  let(:dish) { build :dish }

  describe "#create" do
    context "by not authenticated user" do
      before { post :create }

      it "is not allowed" do
        expect(response).to redirect_to(user_session_path)
      end
    end

    context "by user with non-admin role" do
      before do
        sign_in user
        post :create
      end

      it "is not allowed" do
        expect(response).to redirect_to(root_path)
      end
    end

    context "by admin" do
      before { sign_in admin }
      let(:params) do
        {
          name: dish.name,
          price: dish.price,
          dish_category: { id: dish.category.id },
        }
      end

      it "is allowed" do
        expect { post :create, params }.to change { Dish.count }.by(1)
        expect(assigns(:categories)).not_to be_nil
      end
    end
  end
end
