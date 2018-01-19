require 'sinatra'
# require 'sinatra/reloader'
require 'json'
require_relative 'db_config'
require_relative 'models/inventory'
require_relative 'models/review'
require_relative 'models/user'
require_relative 'models/cart'
# require 'pry'

MAX_ORDER = 10

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
	@cart_amount = Cart.where(user_id: session[:user_id]).sum(:quantity)
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
	
	if params[:email]
		@login_message = "New user #{params[:email]} created!"
	end

	erb :login
end

get '/users/new' do
	erb :users_new
end

post '/users/create' do
	user = User.find_by(email: params[:email])

	if user
		@login_message = "User with email already exists"
		redirect '/users/new'
	else
		new_user = User.create(name: params[:name], email: params[:email], password: params[:password])
		redirect "/users/login?email=#{params[:email]}"
	end
end

get '/store' do
	inventory_fetch = Inventory.all.order(:id)
	if inventory_fetch
		@cart_amount = Cart.where(user_id: session[:user_id]).sum(:quantity)
		@inventory_list = inventory_fetch
		erb :store
	end
end

get '/items/:id' do
	inventory_fetch = Inventory.find_by(id: params[:id])
	if inventory_fetch
		# we use .includes for performance, each time we call .user it calls the db
		@cart_amount = Cart.where(user_id: session[:user_id]).sum(:quantity)
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
	@cart_amount = Cart.where(user_id: session[:user_id]).sum(:quantity)
	cart_details = Cart.includes(:inventory).where(user_id: session[:user_id]).order(:id)
	@price_total = cart_details.sum(:price)

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
end

delete '/cart/delete' do
	Cart.delete(params[:id])
	redirect '/cart'
end

post '/cart/update' do
	update_quantities = params[:values]
	update_quantities.each do |key, value|
		id = value[0]
		new_quantity = value[1]
		Cart.update(id, :quantity => new_quantity)
	end

	redirect '/cart'
end

post '/order' do
	cart_items = Cart.where(user_id: session[:user_id])
	cart_items.each do |item|
		inventory_quantity = Inventory.where(id: item.inventory_id).first.quantity
		Inventory.update(item.inventory_id, :quantity => (inventory_quantity - item.quantity))
		Cart.delete(item.id)
	end

	redirect '/success'
end

get '/success' do
	@cart_amount = 0
	erb :order_success
end



