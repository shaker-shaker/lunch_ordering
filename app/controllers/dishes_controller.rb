class DishesController < ApplicationController
  before_action :user_admin?, only: [:create]
  before_action :fill_categories

  def create
    dish = Dish.new(name: params[:name],
                    price: params[:price],
                    category_id: params[:dish_category][:id],
                    image: params[:image])
    if dish.save
      flash[:success] = t("dishes.item_added")
      redirect_to new_dish_path
    else
      flash.now[:danger] = dish.errors.full_messages.to_sentence
      render :new
    end
  end

  private

  def fill_categories
    @categories = DishCategory.all.map { |d| [d.id, t("dishes.categories.#{d.name}")] }
  end
end
