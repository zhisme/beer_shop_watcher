require 'beer_shop_watcher/version'
require 'beer_shop_watcher/config_loader'
require 'beer_shop_watcher/scraper'
require 'beer_shop_watcher/formatter'
require 'beer_shop_watcher/writer/main'
require 'beer_shop_watcher/view_models/product'
require 'beer_shop_watcher/view/xlsx'
require 'beer_shop_watcher/deliver/mail'

module BeerShopWatcher
  def self.scrape
    config = BeerShopWatcher::ConfigLoader.()

    config['sites'].each do |site|
      hash = BeerShopWatcher::Scraper.(site['url'], site['xpath'])
      name, count = BeerShopWatcher::Formatter.(hash)

      BeerShopWatcher::Writer::Main.(site['url'], site['xpath'].to_json, name, hash['qty'], count)
      AppLogger.debug("#{site['url']} proccessed")
    rescue StandardError => e
      AppLogger.error(e)
      Rollbar.error(e) unless ENV['APP_ENV'] == 'dev'
    end
  end

  def self.export
    products = DB[:products].where { (created_at > Date.today.prev_day) & (created_at < Date.today.next) }

    view_models = products.map do |product|
      ViewModels::Product.new(product).as_json
    end

    filename = View::Xlsx.new.(view_models)

    Deliver::Mail.(filename)
  end
end
