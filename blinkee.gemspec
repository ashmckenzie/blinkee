# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'blinkee/version'

Gem::Specification.new do |spec|
  spec.name          = "blinkee"
  spec.version       = Blinkee::VERSION
  spec.authors       = ["Ash McKenzie"]
  spec.email         = ["ash@greenworm.com.au"]
  spec.description   = %q{Blinkee}
  spec.summary       = %q{Blinkee}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
