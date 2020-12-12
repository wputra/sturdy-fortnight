require 'sinatra'
require 'sinatra/json'
require 'sinatra/activerecord'

set :database_file, 'database.yml'
set :bind, '0.0.0.0'

get '/' do
  json 'Hello World!'
end
