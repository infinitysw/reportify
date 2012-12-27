# -*- encoding: utf-8 -*-
require File.expand_path('../lib/reportify/version', __FILE__)

Gem::Specification.new do |gem|
  gem.name          = "reportify"
  gem.version       = Reportify::VERSION
  gem.authors       = ["jacklin"]
  gem.email         = ["jacklin10@gmail.com"]
  gem.description   = %q{Reportify is used to convert ruby result sets into reports quickly}
  gem.summary       = %q{Reportify is used to convert ruby result sets into reports quickly}
  gem.homepage      = "https://github.com/jacklin10/reportify"

  gem.test_files = Dir["spec/**/*"]
  gem.files = `git ls-files`.split("\n")
  gem.executables = `git ls-files`.split("\n").map{|f| f =~ /^bin\/(.*)/ ? $1 : nil}.compact

  gem.require_paths = ["lib"]
end
