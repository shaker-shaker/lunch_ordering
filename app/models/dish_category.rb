class DishCategory < ActiveRecord::Base
  has_many :dishes, dependent: :delete_all
end
