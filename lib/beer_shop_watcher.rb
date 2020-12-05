require 'beer_shop_watcher/version'
require 'beer_shop_watcher/config_loader'
require 'beer_shop_watcher/logic/scraper'
require 'beer_shop_watcher/logic/formatter'
require 'beer_shop_watcher/writer/main'
require 'beer_shop_watcher/view/main'
require 'beer_shop_watcher/deliver/mail/main'
require 'beer_shop_watcher/reports/main'
require 'beer_shop_watcher/view/reports/daily'
require 'beer_shop_watcher/view/reports/overall'
require 'pry'

module BeerShopWatcher
  def self.scrape # rubocop:disable Metrics/MethodLength, Metrics/AbcSize
    config = ConfigLoader.()

    config[:sites].each do |site|
      hash = Logic::Scraper.(site[:url], site[:xpath])
      name, count = Logic::Formatter.(hash)

      Writer::Main.insert_products(
        site[:url], site[:xpath].to_json, name, hash[:qty], count
      )

      AppLogger.debug("#{site[:url]} proccessed")
    rescue StandardError => e
      AppLogger.error(e)
      notify_rollbar(e)
    end
  end

  def self.export # rubocop:disable Metrics/MethodLength
    daily_data = Reports::Main.('daily')
    overall_data = Reports::Main.('overall')

    daily_view = View::Reports::Daily.new(daily_data)
    overall_view = View::Reports::Overall.new(overall_data)

    daily_report = View::Main.('xlsx', report_view: daily_view)
    overall_report = View::Main.('xlsx', report_view: overall_view)

    Deliver::Mail::Main.('mailgun', attachments: [daily_report, overall_report])

    AppLogger.info("Reports were sent for #{Secrets['recipients'].join(', ')}")
  rescue StandardError => e
    AppLogger.error(e)
    notify_rollbar(e)
  end

  def self.notify_rollbar(error)
    Rollbar.error(error) unless ENV['APP_ENV'] == 'dev'
  end

  private_class_method :notify_rollbar
end
