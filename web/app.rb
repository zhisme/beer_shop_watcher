require 'bundler/setup'
require 'sinatra'
require 'sequel'
require 'beer_shop_watcher/database/connection'
require_relative 'controllers/products/index'
require_relative 'views/products/index'
require_relative 'controllers/api/v1/products/index'
require 'rollbar/middleware/sinatra'
require 'beer_shop_watcher/config/initializers'

set :views, "#{settings.root}/templates"
use Rollbar::Middleware::Sinatra

get '/' do
  controller = Web::Controllers::Products::Index.(params)
  view = Web::Views::Products::Index.(controller.context)

  slim controller.template, locals: { view: view }
end

get '/api/v1/products' do
  controller = Web::Controllers::Api::V1::Products::Index.(params)

  controller.render
end
