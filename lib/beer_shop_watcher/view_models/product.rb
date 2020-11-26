require 'beer_shop_watcher/differentiator'

module BeerShopWatcher
  module ViewModels
    class Product
      attr_reader :record

      def initialize(record)
        @record = record
      end

      def as_json
        record.slice(:url, :name, :count).merge(
          diff_count: BeerShopWatcher::Differentiator.(record),
          created_at: record[:created_at].strftime('%c')
        )
      end
    end
  end
end
