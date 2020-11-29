require 'beer_shop_watcher/writer/sql_writer'

module BeerShopWatcher
  module Writer
    class Main
      def self.insert_products(*args)
        SqlWriter.insert_products(*args)
      end
    end
  end
end
