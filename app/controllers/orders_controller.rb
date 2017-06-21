class OrdersController < ApplicationController
  before_action :collect_dishes, only: [:create]
  before_action :user_admin?, only: [:history]

  def create
    order = Order.new(user_id: current_user.id)
    order.items << @dishes

    if order.save
      flash[:success] = I18n.t "orders.dashboard.order_created"
    else
      flash[:danger] = order.errors.full_messages.to_sentence
    end

    redirect_to new_order_path("menu-date" => Date.today)
  end

  private

  def collect_dishes
    if params[:order] && params[:order][:selected_dishes]
      @dishes = Dish.where(id: params[:order][:selected_dishes].values)
    else
      error_redirect
    end
  end

  def error_redirect
    flash[:danger] = t("orders.dashboard.select_item")
    redirect_to new_order_path("menu-date" => Date.today)
  end
end
