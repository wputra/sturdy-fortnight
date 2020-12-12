require 'sinatra'
require 'sinatra/json'

set :bind, '0.0.0.0'

get '/' do
  json 'Hello World!'
end
