require 'sinatra'
require 'mongo'

namespace :db do
  @db = get_connection
  
  desc 'Seed database'
  task(:seed) do
    @db['users'].insert({ :email => 'mothore@gmail.com', :password => '' })
  end
end

def get_connection
  return @db_connection if @db_connection
  db = URI.parse(ENV['MONGOHQ_URL'] || @config['mongo_uri'])
  db_name = db.path.gsub(/^\//, '')
  @db_connection = Mongo::Connection.new(db.host, db.port).db(db_name)
  @db_connection.authenticate(db.user, db.password) unless (db.user.nil? || db.user.nil?)
  @db_connection
end
