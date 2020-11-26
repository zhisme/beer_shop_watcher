require 'open-uri'
require 'nokogiri'

module BeerShopWatcher
  class Scraper
    def self.call(url, xpath_array)
      doc = Nokogiri::HTML(URI.parse(url).open)
      xpath_array.reduce({}) do |acc, (prop, xpath)|
        acc[prop] = doc.xpath(xpath).text
        acc
      end
    end
  end
end
