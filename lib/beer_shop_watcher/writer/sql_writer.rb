require 'sequel'
require 'beer_shop_watcher/db_config'
require 'logger'

module BeerShopWatcher
  module Writer
    class SqlWriter
      db_conf = BeerShopWatcher::DbConfig.()['psql']

      DB = Sequel.connect(adapter: :postgres, user: db_conf['user'],
                          password: db_conf['password'], host: db_conf['host'],
                          database: db_conf['database'], max_connections: 10, logger: Logger.new('log/db.log'))

      def self.call(url, xpath, inner_text, count)
        DB[:products].insert(url: url, xpath: xpath, inner_text: inner_text, count: count)
      end
    end
  end
end
