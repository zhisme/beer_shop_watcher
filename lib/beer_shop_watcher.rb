require 'beer_shop_watcher/version'
require 'beer_shop_watcher/config_loader'
require 'beer_shop_watcher/scraper'
require 'beer_shop_watcher/formatter'
require 'beer_shop_watcher/writer/main'

module BeerShopWatcher
  def self.run
    config = BeerShopWatcher::ConfigLoader.()

    config['sites'].each do |site|
      hash = BeerShopWatcher::Scraper.(site['url'], site['xpath'])
      name, count = BeerShopWatcher::Formatter.(hash)

      BeerShopWatcher::Writer::Main.(site['url'], site['xpath'].to_json, name, hash['qty'], count)
      AppLogger.current.debug("#{site['url']} proccessed")
    end
  end
end
