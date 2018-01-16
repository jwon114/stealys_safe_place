require 'sinatra'
require 'sinatra/reloader'
require 'uri'
require_relative 'db_config'
require_relative 'models/item'
require_relative 'models/inventory'
require 'pry'

enable :sessions

helpers do


end

get '/' do
	 
	erb :index
end

get '/store' do
	inventory_fetch = Inventory.all
	if inventory_fetch
		@inventory_list = inventory_fetch
		erb :store
	end
end

get '/item/:id' do
	item_fetch = Inventory.find_by(id: params[:id])

	if item_fetch
		@item = item_fetch
		erb :item
	end
end

post '/cart/add' do
	return added to cart
end




