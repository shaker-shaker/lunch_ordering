collection @orders, :root => "orders", :object_root => false
attributes :id, :created_at
child(:user) { attributes :name, :email }
child :dishes, :object_root => false do
	attributes :name, :price, :date
	node :category do |d|
		d.category.name
	end
end
node :total do |o|
	o.total
end