module Api
  module V1
    class ApiController < ActionController::Base
      before_action :check_token
      force_ssl if: :ssl_configured?
      respond_to :json

      # Public: list of the orders for today with details for each
      # person in json format
      #
      # Example:
      #   https://lunchordering.com/api/v1/today_orders.json?api_token=xxx
      def today_orders
        orders = Order.where(created_at: Time.zone.now.all_day).to_a
        orders.map! do |order|
          {
            id: order.id,
            total: order.total,
            items: order.items.map { |item| { name: item.name, price: item.price } },
            user: { id: order.user.id, email: order.user.email, name: order.user.name },
          }
        end

        respond_with(orders: orders)
      end

      private

      def check_token
        user = User.find_by(api_token: params[:token])
        if user.nil? || !user.admin?
          render json: { message: t("api.invalid_token") }
        end
      end

      def ssl_configured?
        !(Rails.env.development? || Rails.env.test?)
      end
    end
  end
end
