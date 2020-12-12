require 'sinatra'
require 'sinatra/json'
require 'sinatra/activerecord'

set :database_file, 'config/database.yml'
set :bind, '0.0.0.0'

class Resource < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
end

get '/' do
  json 'Hello World!'
end
