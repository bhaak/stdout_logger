# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'stdout_logger/version'

Gem::Specification.new do |spec|
  spec.name          = "stdout_logger"
  spec.version       = StdoutLogger::VERSION
  spec.authors       = ["Patric Mueller"]
  spec.email         = ["bhaak@gmx.net"]
  spec.summary       = %q{Redirects stdout and stderr into a log file.}
  spec.description   = %q{Redirects stdout and stderr into a log file.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
end
