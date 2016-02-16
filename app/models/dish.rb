class Dish < ActiveRecord::Base
	belongs_to :category, class_name: "DishCategory"
	has_and_belongs_to_many :orders

  validates :name, presence: true, length: { maximum: 30 }
  validates :date, presence: true
  validate :date_cannot_be_in_the_future_or_weekend
  validates :price, presence: true
  validates_numericality_of :price, greater_than: 0
  validates :category, presence: true

  private

  def date_cannot_be_in_the_future_or_weekend
    errors.add(:date, "day should be today or day in the past") if
    !date.blank? and date > Date.today
    errors.add(:date, "day should not be weekend") if
    !date.blank? and (date.sunday? or date.saturday?)
  end
end
