# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'process_lock/version'

Gem::Specification.new do |spec|
  spec.name          = "process_lock"
  spec.version       = ProcessLock::VERSION
  spec.authors       = ["James Friedman", "Patrick Hereford", "Zach Cotter"]
  spec.email         = ["tech-management@forwardfinancing.com"]

  spec.summary       = "Ensure that a ruby process cannot be run concurrently"
  spec.description   = "Ensures that a ruby process can't be run concurrently"
  spec.homepage      = "https://github.com/ForwardFinancing/process_lock"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency 'redis', '~> 3'
  spec.add_development_dependency "bundler", "~> 1.14"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"
  spec.add_development_dependency 'codeclimate-test-reporter'
  spec.add_development_dependency 'minitest-reporters'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'simplecov'
end
