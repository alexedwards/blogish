# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'blogish/version'

Gem::Specification.new do |gem|
  gem.name          = "blogish"
  gem.version       = Blogish::VERSION
  gem.authors       = ["Alex Edwards"]
  gem.email         = ["ajmedwards@gmail.com"]
  gem.description   = %q{A tiny and powerful blogging engine, wrapped up in a Rubygem. Supports markdown-based posts, syntax highlighting, and RSS feeds.}
  gem.summary       = %q{Markdown-based blog engine}
  gem.homepage      = "https://github.com/alexedwards/blogish"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency "redcarpet"
  gem.add_dependency "rouge"

  gem.add_development_dependency "rspec"
end
