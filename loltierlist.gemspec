# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'loltierlist/version'

Gem::Specification.new do |spec|
  spec.name          = "loltierlist"
  spec.version       = Loltierlist::VERSION
  spec.authors       = ["seanliu93"]
  spec.email         = ["sean93liu@gmail.com"]

  spec.summary       = %q{Provides a tier list for the current League of Legends meta}
  spec.description   = %q{Provides a tier list for the current League of Legends meta}
  spec.homepage      = "https://github.com/seanliu93/loltierlist-cli-gem"
  spec.license       = "MIT"

 

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "bin"
  spec.executables   = ["loltierlist"]
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
