require_relative '../db_config'
require_relative '../models/inventory'

zero_stock = Inventory.where(quantity: 0).select(:id)

if zero_stock.length > 0
	zero_stock.each do |inventory|
		Inventory.update(inventory.id, quantity: rand(5..15))
	end

	puts "Inventory Updated!"
end