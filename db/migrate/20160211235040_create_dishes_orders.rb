class CreateDishesOrders < ActiveRecord::Migration
	def change
		create_table :dishes_orders , id: false do |t|
			t.belongs_to :order, index: true
			t.belongs_to :dish, index: true
		end
	end
end
