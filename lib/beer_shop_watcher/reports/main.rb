require 'beer_shop_watcher/reports/daily'
require 'beer_shop_watcher/reports/overall'

module BeerShopWatcher
  module Reports
    class UnknownReportType < StandardError; end

    class Main
      def self.call(type)
        case type
        when 'daily'
          Daily.()
        when 'overall'
          Overall.()
        else
          raise UnknownReportType
        end
      end
    end
  end
end
