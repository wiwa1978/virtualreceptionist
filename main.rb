# encoding: UTF-8
require 'json'
require 'sinatra'
require 'data_mapper'
require 'dm-migrations'
require 'sinatra/flash'
require 'sinatra-authentication'
require 'digest/sha1'
require 'haml'
require 'rack-flash'
require 'csv'

use Rack::Flash
enable :sessions

use Rack::Session::Cookie, :secret => 'S3cr3t'
set :sinatra_authentication_view_path, Pathname(__FILE__).dirname.expand_path + "views/authentication"

configure :development do
  DataMapper::Logger.new($stdout, :debug)
  DataMapper.setup(:default, ENV['DATABASE_URL'] || "sqlite3://#{Dir.pwd}/employees.db")
end

configure :production do
  DataMapper.setup(
    :default,
    ENV['HEROKU_POSTGRESQL_NAVY_URL']
  )
end


require './models/init'
require './helpers/init'
require './routes/init'

DataMapper.finalize 