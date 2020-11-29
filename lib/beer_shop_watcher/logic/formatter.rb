module BeerShopWatcher
  module Logic
    class Formatter
      def self.call(scraped_hash)
        count, _rest = scraped_hash['qty'].match(/\d+/).to_a

        [scraped_hash['name'].strip, count.to_i]
      end
    end
  end
end
