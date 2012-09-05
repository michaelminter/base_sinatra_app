require 'sinatra'

get '/' do
  erb :index
end

not_found do
  erb :not_found
end

error do
  'Sorry there was a nasty error - ' + env['sinatra.error'].name
end
