require 'yaml'

module BeerShopWatcher
  class ConfigLoader
    def self.call
      YAML.safe_load(File.read('beer_sites.yml'))
    end
  end
end
