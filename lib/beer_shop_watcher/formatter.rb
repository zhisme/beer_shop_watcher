module BeerShopWatcher
  class Formatter
    def self.call(inner_text)
      count, _rest = inner_text.match(/\d+/).to_a

      count
    end
  end
end
