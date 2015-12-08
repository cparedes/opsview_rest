# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |gem|
  gem.name = "opsview_rest"
  gem.summary = %Q{Opsview REST API library}
  gem.description = %Q{Update configuration on Opsview server via REST API}
  gem.email = "christian.paredes@seattlebiomed.org"
  gem.homepage = "http://github.com/cparedes/opsview_rest"
  gem.authors = ["Christian Paredes"]
  gem.license       = 'Apache'

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ['lib']

  gem.add_development_dependency "rake", "~> 10.1.1"
  gem.add_development_dependency "rspec", "~> 2.14.1"
  gem.add_development_dependency "yard", "~> 0.8.7.3"
  gem.add_development_dependency "webmock", "~> 1.11.0"

  gem.add_dependency 'json', '~> 1.7.7'
  gem.add_dependency 'rest-client', '~> 1.6.6'

  gem.version = '0.4.3'
end
