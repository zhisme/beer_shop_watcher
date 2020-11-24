require 'yaml'

module BeerShopWatcher
  class DbConfig
    def self.call
      YAML.safe_load(File.read('.db_config.yml'))
    end
  end
end
