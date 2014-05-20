# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'brightpearl_api/version'

Gem::Specification.new do |spec|
  spec.name          = "brightpearl_api"
  spec.version       = BrightpearlApi::VERSION
  spec.authors       = ["Kunwar Aditya Raghuwanshi"]
  spec.email         = ["adi.version1@gmail.com"]
  spec.summary       = %q{Brightpearl API Library}
  spec.description   = %q{Gem for connecting to your brightpearl account via their API}
  spec.homepage      = "http://github.com/kitwalker12/brightpearl_api"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "pry"

  spec.add_runtime_dependency "activesupport"
  spec.add_runtime_dependency "httparty"
end
