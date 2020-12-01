require 'yaml'

module BeerShopWatcher
  class ConfigLoader
    def self.call
      YAML.safe_load(File.read('beer_sites.yml'), aliases: true, permitted_classes: [Symbol])
    end
  end
end
