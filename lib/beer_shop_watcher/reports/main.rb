require 'beer_shop_watcher/reports/daily'

module BeerShopWatcher
  module Reports
    class Main
      def self.call(type)
        case type
        when 'daily'
          Daily.()
        end
      end
    end
  end
end
