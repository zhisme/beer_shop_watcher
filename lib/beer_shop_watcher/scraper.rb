require 'open-uri'
require 'nokogiri'

module BeerShopWatcher
  class Scraper
    def self.call(url, xpath)
      doc = Nokogiri::HTML(URI.parse(url).open)
      doc.xpath(xpath).text
    end
  end
end
