require 'bundler/setup'
require 'sinatra'
require 'sequel'
require 'beer_shop_watcher/database/connection'
require_relative 'controllers/products/index'
require_relative 'views/products/index'

set :views, "#{settings.root}/templates"

get '/' do
  controller = Web::Controllers::Products::Index.(params)
  view = Web::Views::Products::Index.(controller.context)

  slim controller.template, locals: { view: view }
end
