require 'logger'

AppLogger ||= Logger.new(ENV['LOGGER'] || $stdout, 'weekly')
