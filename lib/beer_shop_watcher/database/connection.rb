require 'sequel'
require 'logger'
require 'beer_shop_watcher/database/db_config'

module BeerShopWatcher
  module Database
    class Connection
      class << self
        attr_reader :current
      end

      db_conf = BeerShopWatcher::DbConfig.()['psql']
      @current ||= Sequel.connect(adapter: :postgres, user: db_conf['user'],
                                  password: db_conf['password'], host: db_conf['host'],
                                  database: db_conf['database'], max_connections: 10, logger: Logger.new('log/db.log'))
    end
  end
end
