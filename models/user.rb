class User < ActiveRecord::Base
	has_secure_password
	has_many :reviews
	has_many :carts
	validates :email, 
		presence: true,
		uniqueness: true
	validates :password, 
		presence: true
end