# -*- encoding: utf-8 -*-
require File.expand_path('../lib/cukebase/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Emil Loer"]
  gem.email         = ["emil@bartune.nl"]
  gem.description   = %q{Cukebase provides integration between Cucumber and the Codebase ticketing system}
  gem.summary       = %q{Cukebase provides integration between Cucumber and the Codebase ticketing system}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "cukebase"
  gem.require_paths = ["lib"]
  gem.version       = Cukebase::VERSION

  gem.add_dependency 'httparty'
  gem.add_dependency 'activemodel'
  gem.add_dependency 'active_attr'
end
