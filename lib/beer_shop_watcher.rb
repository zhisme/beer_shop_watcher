require 'beer_shop_watcher/version'
require 'beer_shop_watcher/config_loader'
require 'beer_shop_watcher/logic/scraper'
require 'beer_shop_watcher/logic/formatter'
require 'beer_shop_watcher/writer/main'
require 'beer_shop_watcher/view/main'
require 'beer_shop_watcher/deliver/mail/main'
require 'beer_shop_watcher/reports/main'

module BeerShopWatcher
  def self.scrape # rubocop:disable Metrics/MethodLength, Metrics/AbcSize
    config = ConfigLoader.()

    config['sites'].each do |site|
      hash = Logic::Scraper.(site['url'], site['xpath'])
      name, count = Logic::Formatter.(hash)

      Writer::Main.insert_products(
        site['url'], site['xpath'].to_json, name, hash['qty'], count
      )

      AppLogger.debug("#{site['url']} proccessed")
    rescue StandardError => e
      AppLogger.error(e)
      notify_rollbar(e)
    end
  end

  def self.export(report_type = 'daily')
    data = Reports::Main.(report_type)

    attachment = View::Main.('xlsx', data: data)

    Deliver::Mail::Main.('mailgun', attachment: attachment)

    AppLogger.info("#{report_type} report was sent for #{Secrets['recipients'].join(', ')}")
  rescue StandardError => e
    AppLogger.error(e)
    notify_rollbar(e)
  end

  def self.notify_rollbar(error)
    Rollbar.error(error) unless ENV['APP_ENV'] == 'dev'
  end

  private_class_method :notify_rollbar
end
