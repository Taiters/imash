# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'imash/version'

Gem::Specification.new do |spec|
  spec.name          = "imash"
  spec.version       = Imash::VERSION
  spec.authors       = ["Daniel Tait"]
  spec.email         = ["dantait91@gmail.com"]
  spec.summary       = "Make images from strings"
  spec.description   = "An attempt at gravatar/identicon style images using strings in ruby"
  spec.homepage      = "https://github.com/Taiters/imash"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"

  spec.add_runtime_dependency "chunky_png", "~> 1.3"
end
