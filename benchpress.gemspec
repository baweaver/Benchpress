# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'benchpress/version'

Gem::Specification.new do |spec|
  spec.name          = "benchpress"
  spec.version       = Benchpress::VERSION
  spec.authors       = ["Brandon Weaver"]
  spec.email         = ["keystonelemur@gmail.com"]
  spec.description   = %q{Pit Ruby methods against eachother in benchmark, and chart for great glory}
  spec.summary       = %q{Ruby Benchmark + Gruff to auto-gen charts for method profiline}
  spec.homepage      = "https://github.com/baweaver/Benchpress"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"

  spec.add_runtime_dependency "gruff"
end
