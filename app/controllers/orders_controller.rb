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
      flash.now[:danger] = "Error while placing order,"\
                           "please, contact to administrator"
    end
  end

  def history
    date = Date.strptime(params[:date], "%d/%m/%Y")
    @orders_history = { 
      orders: Order.where("created_at::date = :date ", { date: date }),
      date: date
    }
    respond_with @orders_history
  end

  private
  def correct_dishes
    if params[:order][:ordered].present?
      @dishes = params[:order][:ordered].values.collect do |v| 
        Dish.find_by(id: v) 
      end.uniq { |e| e[:category_id] }
    else   
      flash.now[:danger] = "Please, choose at least one product"
      respond_to { |format| format.js }
    end
  end
end