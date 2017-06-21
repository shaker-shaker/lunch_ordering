require "rails_helper"

RSpec.describe UsersController, type: :controller do
  let!(:admin) { create :user }
  let!(:user) { create :user }

  describe "#list" do
    context "by not authenticated user" do
      before { get :list }

      it "is not allowed" do
        expect(response).to redirect_to(user_session_path)
      end
    end

    context "by user with non-admin role" do
      before do
        sign_in user
        get :list
      end

      it "is not allowed" do
        expect(response).to redirect_to(root_path)
      end
    end

    context "by admin" do
      before do
        sign_in admin
        get :list
      end

      it "is allowed" do
        expect(assigns(:users)).to eq User.all
      end
    end
  end
end
