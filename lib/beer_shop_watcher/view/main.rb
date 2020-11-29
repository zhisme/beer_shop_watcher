require 'beer_shop_watcher/view/xlsx'

module BeerShopWatcher
  module View
    class Main
      class UnknownType < StandardError; end

      def self.call(type, **opts)
        case type
        when 'xlsx'
          Xlsx.(**opts)
        else
          raise UnknownType
        end
      end
    end
  end
end
