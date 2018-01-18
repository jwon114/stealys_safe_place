require 'active_record'

options = {
	adapter: 'postgresql',
	database: 'stealys_safe_place'
}

ActiveRecord::Base.establish_connection( ENV['DATABASE_URL'] || options)