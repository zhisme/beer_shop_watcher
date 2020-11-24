require 'beer_shop_watcher/version'
require 'beer_shop_watcher/config_loader'
require 'beer_shop_watcher/scraper'
require 'beer_shop_watcher/formatter'
require 'beer_shop_watcher/writer/main'

config = BeerShopWatcher::ConfigLoader.()
config['sites'].each do |site|
  inner_text = BeerShopWatcher::Scraper.(site['url'], site['xpath'])
  count = BeerShopWatcher::Formatter.(inner_text)

  BeerShopWatcher::Writer::Main.(site['url'], site['xpath'], inner_text, count)
  puts "#{site['url']} proccessed"
end
