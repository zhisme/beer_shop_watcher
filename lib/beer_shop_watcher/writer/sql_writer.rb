require 'sequel'
require 'logger'

module BeerShopWatcher
  module Writer
    class SqlWriter
      def self.call(url, xpath, name, inner_text, count)
        DB[:products].insert(url: url, xpath: xpath, name: name, inner_text: inner_text, count: count, created_at: Time.now)
      end
    end
  end
end
