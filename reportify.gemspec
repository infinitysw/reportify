# -*- encoding: utf-8 -*-
require File.expand_path('../lib/reportify/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["jacklin"]
  gem.email         = ["jacklin10@gmail.com"]
  gem.description   = %q{Reportify is used to convert ruby result sets into reports quickly}
  gem.summary       = %q{Reportify is used to convert ruby result sets into reports quickly}
  gem.homepage      = "https://github.com/jacklin10/reportify"

  ignores = File.readlines(".gitignore").grep(/\S+/).map {|s| s.chomp }
  dotfiles = [".gemtest", ".gitignore", ".rspec", ".yardopts"]
  gem.files = Dir["**/*"].reject {|f| File.directory?(f) || ignores.any? {|i| File.fnmatch(i, f) } } + dotfiles
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})

  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.name          = "reportify"
  gem.require_paths = ["lib"]
  gem.version       = Reportify::VERSION
end
