class Api::V1::ApiController < ApplicationController
  before_action :check_token

  def today_orders
    @orders = Order.where("created_at::date = :date ", {date: Date.today})
    render 'api/v1/today_orders'
  end

  private
    def check_token
      unless User.where(api_token: params[:token]).any?
        @error =  OpenStruct.new({ message: "Invalid token" })
        render 'api/v1/error' 
      end
    end
end
