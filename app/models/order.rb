class Order < ActiveRecord::Base
	belongs_to :user
	has_and_belongs_to_many :dishes
  validates :user_id, presence: true
  validate :order_must_have_at_least_one_dish

  def total
    self.dishes.sum(:price)
  end

  private
  def order_must_have_at_least_one_dish
    unless dishes.present? && dishes.any?
      errors.add(:dishes, "order must have at least one dish")
    end
  end
end
