require 'sinatra'
require 'sinatra/reloader'
require 'uri'
require_relative 'db_config'
require_relative 'models/inventory'
require_relative 'models/review'
require_relative 'models/user'
require 'pry'

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
end

get '/' do
	 
	erb :index
end

get '/login' do
	erb :login
end

post '/session' do
	user = User.find_by(email: params[:email])

	if user && user.authenticate(params[:password])
		session[:user_id] = user.id
		puts session[:user_id]
		redirect '/store'
	else
		erb :index
	end
end

delete '/session' do
	session[:user_id] = nil
	redirect '/'
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
		redirect '/'
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
	item_fetch = Inventory.find_by(id: params[:id])
	if item_fetch
		@reviews_list = Review.includes(:user).where(inventory_id: params[:id])
		@item = item_fetch
		erb :item
	end
end

post '/reviews/:id' do
	new_review = Review.create(inventory_id: params[:id], user_id: session[:user_id], review: params[:review])
	redirect '/items/' + params[:id]
end

post '/cart/add' do
	return added to cart
end



