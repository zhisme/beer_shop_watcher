require 'sequel'
require 'logger'

module BeerShopWatcher
  module Writer
    class SqlWriter
      def self.insert_products(url, xpath, name, inner_text, count)
        DB[:products].insert(url: url, xpath: xpath, name: name, inner_text: inner_text, count: count)
      end
    end
  end
end
