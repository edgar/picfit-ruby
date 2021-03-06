# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'picfit/version'

Gem::Specification.new do |spec|
  spec.name          = "picfit"
  spec.version       = Picfit::VERSION
  spec.authors       = ["Edgar Gonzalez"]
  spec.email         = ["edgargonzalez@gmail.com"]

  spec.summary       = %q{A Ruby library for generating URLs with picfit.}
  spec.description   = %q{A Ruby library for generating URLs with picfit.}
  spec.homepage      = "http://github.com/edgar/picfit-ruby"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.9"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
end
