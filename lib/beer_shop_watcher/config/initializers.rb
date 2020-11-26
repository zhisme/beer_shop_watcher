require 'rollbar'
require 'yaml'

ENV['APP_ENV'] ||= 'dev'

Secrets = YAML.safe_load(File.read('secrets.yml'))[ENV['APP_ENV']]

Rollbar.configure do |config|
  config.access_token = Secrets['rollbar']
end
