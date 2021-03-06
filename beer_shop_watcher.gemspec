lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'beer_shop_watcher/version'

Gem::Specification.new do |spec|
  spec.name          = 'beer_shop_watcher'
  spec.version       = BeerShopWatcher::VERSION
  spec.authors       = ['Zhdanov']
  spec.email         = ['evdev34@gmail.com']

  spec.summary       = ''
  spec.description   = ''
  spec.license       = 'MIT'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']
  spec.required_ruby_version = '>= 2.7.1'

  spec.add_dependency 'caxlsx'
  spec.add_dependency 'nokogiri', '~> 1.10'
  spec.add_dependency 'pg', '~> 1.2.3'
  spec.add_dependency 'rest-client'
  spec.add_dependency 'rollbar'
  spec.add_dependency 'sequel', '~> 5.38'
  spec.add_dependency 'sequel_pg', '~> 1.14'
  spec.add_dependency 'sequel_postgresql_triggers'
  spec.add_dependency 'sinatra', '2.1'
  spec.add_dependency 'slim', '4.1'
  spec.add_dependency 'puma', '5.1'

  spec.add_development_dependency 'bundler', '~> 1.16.5'
  spec.add_development_dependency 'pry', '~> 0.13'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rubocop', '~> 1.0'
end
