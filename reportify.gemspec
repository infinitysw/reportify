# -*- encoding: utf-8 -*-
require File.expand_path('../lib/reportify/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["jacklin"]
  gem.email         = ["jacklin10@gmail.com"]
  gem.description   = %q{Reportify is used to convert ruby result sets into reports quickly}
  gem.summary       = %q{Reportify is used to convert ruby result sets into reports quickly}
  gem.homepage      = "https://github.com/jacklin10/reportify"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "reportify"
  gem.require_paths = ["lib"]
  gem.version       = Reportify::VERSION
end
