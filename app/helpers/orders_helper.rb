module OrdersHelper
  def menu_form(date)
    render "orders/menu/menu_form", dishes: Dish.where(created_at: date.to_time.all_day)
  end

  def orders_history(date)
    render "orders/order_history_table", orders: Order.where(created_at: date.to_time.all_day)
  end
end
