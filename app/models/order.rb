class Order < ActiveRecord::Base
  belongs_to :user
  has_and_belongs_to_many :items, class_name: "Dish"
  validates :user_id, presence: true
  validate :order_must_have_at_least_one_item

  def total
    items.sum(:price)
  end

  private

  def order_must_have_at_least_one_item
    unless items.present? && items.any?
      errors.add(:items, I18n.t("orders.model.no_items_in_order"))
    end
  end

  def order_items_must_have_unique_category
    I18n.t("orders.model.several_items_with_same_category") if items.map(&:category_id).uniq.length < items.count
  end
end
