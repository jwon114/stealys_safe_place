class Inventory < ActiveRecord::Base
	has_many :carts
	has_many :reviews
end
