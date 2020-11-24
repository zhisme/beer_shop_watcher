require 'beer_shop_watcher/writer/sql_writer'

module BeerShopWatcher
  module Writer
    class Main
      def self.call(*args)
        SqlWriter.(*args)
      end
    end
  end
end
