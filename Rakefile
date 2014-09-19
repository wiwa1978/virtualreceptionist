require 'dm-migrations'

desc "List all routes for this application"
task :routes do
  puts `grep '^[get|post|put|delete].*do$' routes/*.rb | sed 's/ do$//'`
end

desc "auto migrates the database"
task :migrate do
  require './main'
  DataMapper.auto_migrate!
end

desc "auto upgrades the database"
task :upgrade do
  require './main'
  DataMapper.auto_upgrade! 
end

desc 'Load the seed data from db/seeds.rb'
task :seed do
	require './main'
	seed_file = File.join('db/seeds.rb')
  	load(seed_file) if File.exist?(seed_file)
end
