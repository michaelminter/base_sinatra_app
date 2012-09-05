require 'sinatra'
require 'yaml'
require 'mongo'

before do
  @config = {}
  begin
    @config = YAML::load_file('config/config.yml')
  rescue Errno::ENOENT => e
  end
  
  @db = get_connection
end

def get_connection
  return @db_connection if @db_connection
  db = URI.parse(ENV['MONGOHQ_URL'] || @config['mongo_uri'])
  db_name = db.path.gsub(/^\//, '')
  @db_connection = Mongo::Connection.new(db.host, db.port).db(db_name)
  @db_connection.authenticate(db.user, db.password) unless (db.user.nil? || db.user.nil?)
  @db_connection
end

get '/' do
  erb :index
end

get '/users' do
  @users = @db['users']
  erb :users_index
end

get '/user/:id/edit' do
   @users = User.all
   @user = User.find(params[:id])
   erb :edit
end

post '/user/new' do
   user = User.new
   user.email = (params[:email])

   if user.save
      status 201
   else
      status 401
   end

   redirect '/'
end

put '/user/:id/update' do
   user = User.find(params[:id])
   user.email = (params[:email])
            
   if user.save
      status 201 
   else
      status 401
   end
   
   redirect '/'

end

get '/user/:id/delete' do
  @users = User.all
   @user = User.find(params[:id]) 
   erb :delete
end

delete '/user/:id/delete' do
   User.find(params[:id]).destroy
   redirect '/'
end

not_found do
  erb :not_found
end

error do
  'Sorry there was a nasty error - ' + env['sinatra.error'].email
end
