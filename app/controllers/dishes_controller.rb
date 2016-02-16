class DishesController < ApplicationController
	before_action :authenticate_user!
  before_action :check_for_admin, only: [:create]
	respond_to :html, :js

	def menu
    return_menu(Date.strptime(params[:date], "%d/%m/%Y"))
  end

  def create
    dish = Dish.new(name: params[:name],
      price: params[:price],
      category: DishCategory.find_by_id(params[:dish_category][:id]),
      date: Date.today)
    if dish.save
      flash.now[:success] = "New menu item added"
    else
      flash.now[:danger] = dish.errors.full_messages.join('</br>')
    end

    return_menu Date.today
  end

  private

  def return_menu(date)
    @menu = 
    { 
      menu: Dish.where("date::date = :dish_date ", {dish_date: date}),
      html_container: params[:html_container],
      selectable: params[:selectable]
    }
    respond_with @menu
  end
end
