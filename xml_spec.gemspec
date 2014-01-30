# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'xml_spec/version'

Gem::Specification.new do |spec|
  spec.name          = "xml_spec"
  spec.version       = XmlSpec::VERSION
  spec.authors       = ["C. Jason Harrelson"]
  spec.email         = ["jason@lookforwardenterprises.com"]
  spec.summary       = %q{XML matchers for specs.}
  spec.description   = %q{XML matchers for specs.  See README for more info.}
  spec.homepage      = "https://github.com/midas/xml_spec"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  #spec.add_dependency "multi_json", "~> 1.0"
  spec.add_dependency "activesupport", ">= 3"
  spec.add_dependency "builder", ">= 3"
  spec.add_dependency "equivalent-xml"
  spec.add_dependency "nokogiri", "~> 1"
  spec.add_dependency "nori", "~> 2"
  spec.add_dependency "rspec", "~> 2"

  spec.add_development_dependency "bundler", "~> 1"
  spec.add_development_dependency "guard-rspec"
  spec.add_development_dependency "rake"
end
