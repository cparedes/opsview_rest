# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |gem|
  gem.name = "opsview_rest"
  gem.summary = "Opsview REST API library"
  gem.description = "Update configuration on Opsview server via REST API"
  gem.email = "christian.paredes@seattlebiomed.org"
  gem.homepage = "http://github.com/cparedes/opsview_rest"
  gem.authors = ["Christian Paredes"]
  gem.license       = 'Apache'

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ['lib']

  gem.add_development_dependency "rake", "~> 11.3.0"
  gem.add_development_dependency "rspec", "~> 3.5.0"
  gem.add_development_dependency "yard", "~> 0.9.5"
  gem.add_development_dependency "webmock", "~> 2.1.0"

  gem.add_dependency 'json', '~> 2.0.2'
  gem.add_dependency 'rest-client', '~> 2.0.0'

  gem.version = '0.4.4'
end
