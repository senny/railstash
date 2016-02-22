# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'railstash/version'

Gem::Specification.new do |spec|
  spec.name          = "railstash"
  spec.version       = Railstash::VERSION
  spec.authors       = ["Yves Senn"]
  spec.email         = ["yves.senn@gmail.com"]

  spec.summary       = %q{Writes Logstash specific Rails logs.}
  spec.description   = %q{Railstash provides a simple way to write Rails events into Logstash and augment them with your own information.}
  spec.homepage      = "https://github.com/senny/railstash"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"
end
