require 'sinatra'
require 'sinatra/reloader'
require 'json'
require_relative 'db_config'
require_relative 'models/inventory'
require_relative 'models/review'
require_relative 'models/user'
require_relative 'models/cart'
require 'pry'

MAX_ORDER = 10

# TODO:
# login.erb
# adding to cart
# can't add to cart unless logged in

enable :sessions

helpers do
	def current_user
		User.find_by(id: session[:user_id])
	end

	def logged_in?
		!!current_user
	end

	def cart_has_item?(user_id, inventory_id)
		return Cart.exists?(:inventory_id => inventory_id, :user_id => user_id)
	end
end

get '/' do
	 
	erb :index
end


post '/session' do
	user = User.find_by(email: params[:email])

	if user && user.authenticate(params[:password])
		session[:user_id] = user.id
		redirect '/store'
	else
		if user == nil
			@error = "No such Email and Password combination exists, try create a new user"
		else
			@error = "Email and Password are incorrect"
		end

		erb :login
	end
end

delete '/session' do
	session[:user_id] = nil
	redirect '/'
end

get '/users/login' do
	erb :login
end

get '/users/new' do
	erb :users_new
end

post '/users/create' do
	user = User.find_by(email: params[:email])

	if user
		@error = "User with email already exists"
		redirect '/users/new'
	else
		new_user = User.create(name: params[:name], email: params[:email], password: params[:password])
		redirect '/store'
	end
end

get '/store' do
	inventory_fetch = Inventory.all
	if inventory_fetch
		@inventory_list = inventory_fetch
		erb :store
	end
end

get '/items/:id' do
	inventory_fetch = Inventory.find_by(id: params[:id])
	if inventory_fetch
		# we use .includes for performance, each time we call .user it calls the db
		reviews_fetch = Review.includes(:user).where(inventory_id: params[:id])
		@reviews_list = []
		reviews_fetch.each do |review| 
			rating = "<div class='starReadOnly' data-rateyo-rating='#{review.rating.to_i}'></div>"
			@reviews_list << { data: review, review_rating: rating }
		end
		@item = inventory_fetch
		if @item.quantity > 0
			@stock = "In Stock"
		else
			@stock = "Out of Stock"
		end
		erb :item
	end
end

post '/reviews/:id' do
	new_review = Review.create(inventory_id: params[:id], user_id: session[:user_id], review_text: params[:review], rating: params[:rating])
	redirect '/items/' + params[:id]
end

get '/cart' do

	@cart_fetch = Cart.includes(:inventory).where(user_id: session[:user_id])
	# @price_total

	erb :cart
end

get '/cart/amount' do
	cart_amount = Cart.where(user_id: session[:user_id]).count
	return JSON.generate(cart_amount)
end

post '/cart/add' do
	inventory_fetch = Inventory.find_by(id: params[:id])

	# only allow adding to cart if we have the item in stock
	if inventory_fetch.quantity >= params[:quantity].to_i
		# if a cart entry for the user exists, show  it, otherwise create a new one
		if cart_has_item?(session[:user_id], params[:id])
			# pop up
			cart_fetch = Cart.find_by(user_id: session[:user_id], inventory_id: params[:id])
			cart_fetch.quantity = params[:quantity]
			cart_fetch.save
			result = JSON.generate({ message: "updated cart" })
		else
			new_cart = Cart.create(inventory_id: params[:id], user_id: session[:user_id], quantity: params[:quantity])
			result = JSON.generate({ message: "added to cart", quantity: params[:quantity] })
		end
		return result
	else
		# there is not enough stock
		return "no stock"
	end

end

post '/order' do

end



