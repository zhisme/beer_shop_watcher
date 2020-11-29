require 'open-uri'
require 'nokogiri'

module BeerShopWatcher
  module Logic
    class Scraper
      def self.call(url, xpath_array)
        doc = Nokogiri::HTML(URI.parse(url).open)
        xpath_array.each_with_object({}) do |(prop, xpath), acc|
          acc[prop] = doc.xpath(xpath).text
        end
      end
    end
  end
end
