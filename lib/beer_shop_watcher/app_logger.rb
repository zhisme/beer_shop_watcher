require 'logger'

module BeerShopWatcher
  class AppLogger
    class << self
      attr_reader :current
    end

    @current ||= Logger.new(ENV['LOGGER'] || $stdout)
  end
end
