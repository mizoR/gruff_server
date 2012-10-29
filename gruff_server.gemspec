# -*- encoding: utf-8 -*-
require File.expand_path('../lib/gruff_server/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Ryutaro MIZOKAMI"]
  gem.email         = ["suzunatsu@yahoo.com"]
  gem.description   = %q{gruff server}
  gem.summary       = %q{gruff server}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "gruff_server"
  gem.require_paths = ["lib"]
  gem.version       = GruffServer::VERSION

  gem.add_dependency 'rmagick', '~> 2.13.1'
  gem.add_dependency 'gruff'  , '~> 0.3.7'
  gem.add_dependency 'rack'   , '~> 1.4.1'
  gem.add_dependency 'sinatra', '~> 1.3.3'
end
