class Dish < ActiveRecord::Base
  mount_uploader :image, MenuItemImageUploader

  belongs_to :category, class_name: "DishCategory"
  has_and_belongs_to_many :orders

  validates :name, presence: true, length: { maximum: 30 }
  validates :price, presence: true
  validates_numericality_of :price, greater_than: 0
  validates :category, presence: true
end
