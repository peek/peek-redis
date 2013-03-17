# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'glimpse-redis/version'

Gem::Specification.new do |gem|
  gem.name          = 'glimpse-redis'
  gem.version       = Glimpse::Redis::VERSION
  gem.authors       = ['Garrett Bjerkhoel']
  gem.email         = ['me@garrettbjerkhoel.com']
  gem.description   = %q{Provide a glimpse into the Redis calls made within your Rails application.}
  gem.summary       = %q{Provide a glimpse into the Redis calls made within your Rails application.}
  gem.homepage      = 'https://github.com/dewski/glimpse-redis'

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ['lib']

  gem.add_dependency 'glimpse'
  gem.add_dependency 'redis'
  gem.add_dependency 'atomic', '>= 1.0.0'
end
