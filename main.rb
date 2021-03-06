require 'sinatra'
# require 'sinatra/reloader'
require 'json'
require 'uri'
require_relative 'db_config'
require_relative 'models/inventory'
require_relative 'models/review'
require_relative 'models/user'
require_relative 'models/cart'
# require 'pry'

MAX_ORDER = 10

# TODO:
# validations in class Models

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

	def get_cart_amount
		Cart.where(user_id: session[:user_id]).sum(:quantity)
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
			@login_message = "No such Email and Password combination exists, try create a new user"
		else
			@login_message = "Email and Password are incorrect"
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
	new_user = User.new
	new_user.name = params[:name]
	new_user.email = params[:email]
	new_user.password = params[:password]

	if new_user.save
		session[:user_id] = new_user.id
		redirect '/store'
	else
		@login_error_messages = new_user.errors.full_messages
		erb :users_new
	end
end

get '/store' do
	inventory_fetch = Inventory.all.order(:id)
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
			if @item.quantity > MAX_ORDER
				@quantity = MAX_ORDER
			else
				@quantity = @item.quantity
			end
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
	cart_details = Cart.includes(:inventory).where(user_id: session[:user_id]).order(:id)
	@price_total = cart_details.sum(:price)
	@user_id = session[:user_id]

	@send_to_cart = []
	cart_details.each do |cart_item|
		if cart_item.inventory.quantity > MAX_ORDER
			quantity = MAX_ORDER
		else
			quantity = cart_item.inventory.quantity
		end
		@send_to_cart << { :details => cart_item, :quantity_select => quantity }
	end

	erb :cart
end

post '/cart/add' do
	inventory_fetch = Inventory.find_by(id: params[:id])

	if session[:user_id] != nil
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
		end
	else
		return JSON.generate({ message: "user not logged in" })
	end
end

delete '/cart/delete' do
	Cart.delete(params[:id])
	redirect '/cart'
end

put '/cart/update' do
	update_quantities = JSON.parse(params[:select_values])
	update_quantities.each do |item|
		Cart.update(item["id"], :quantity => item["value"].to_i)
	end

	return JSON.generate({ message: "cart updated", select_values: update_quantities })
end

post '/order/:user_id' do
	@cart_items = Cart.includes(:inventory).where(user_id: params[:user_id]).order(:id)
	# check if the item quantity in cart can be deducted from inventory
	@cart_items_failed = []
	@cart_items.each do |item|
		inventory_quantity = Inventory.where(id: item.inventory_id).first.quantity
		if inventory_quantity - item.quantity < 0
			@cart_items_failed << item
		end
	end

	if @cart_items_failed.empty?
		@price_total = @cart_items.sum(:price)

		@cart_items.each do |item|
			inventory_quantity = Inventory.where(id: item.inventory_id).first.quantity
			Inventory.update(item.inventory_id, :quantity => (inventory_quantity - item.quantity))
			Cart.delete(item.id)
		end

		erb :order_success
	else

		erb :order_failed
	end
end



