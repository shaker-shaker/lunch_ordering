class OrdersController < ApplicationController
	before_action :authenticate_user!
  before_action :correct_dishes, only: [:create]
  before_action :check_for_admin, only: [:history]
	respond_to :html, :js
	
	def create
    order = Order.new(user_id: params[:order][:user_id])
    @dishes.each do |d|
      order.dishes << d
    end
    if order.save
      flash.now[:success] = "Order placed"
    else
      flash.now[:danger] = "Error while placing order, please, contact to administrator"
    end
  end

  def history
    date = Date.strptime(params[:date], "%d/%m/%Y")
    @orders_history = 
    { 
      orders: Order.where("created_at::date = :date ", {date: date}),
      date: date
    }
    respond_with @orders_history
  end

  private

  def correct_dishes
    unless params[:order][:ordered].present?
      flash.now[:danger] = "Please, choose at least one product"
      respond_to do |format|
        format.js
      end
    else   
      @dishes = params[:order][:ordered].values.collect { |v|  Dish.find_by(id: v) }
      .uniq {|e| e[:category_id]}
    end
  end
end