require 'sinatra'
require 'sinatra/reloader'
require_relative 'db_config'

enable :sessions

get '/' do
  erb :index
end





