# -*- encoding: utf-8 -*-
require File.expand_path('../lib/hanover/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Bryce Kerley"]
  gem.email         = ["bkerley@brycekerley.net"]
  gem.description   = %q{A Riak-based CRDT implementation of sets and counters.}
  gem.summary       = %q{Riak-based CRDT implementation.}
  gem.homepage      = "https://github.com/bkerley/hanover"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "hanover"
  gem.require_paths = ["lib"]
  gem.version       = Hanover::VERSION
  
  gem.add_dependency 'riak-client', '~> 1.0.3'
  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'minitest'
  gem.add_development_dependency 'shoulda-context'
end
