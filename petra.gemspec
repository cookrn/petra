# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'petra/version'

Gem::Specification.new do |spec|
  spec.name          = 'petra'
  spec.version       = Petra::VERSION
  spec.authors       = ['Ryan Cook']
  spec.email         = ['cookrn@gmail.com']
  spec.description   = %q{A toolkit for interacting with Ansible from Ruby}
  spec.summary       = "#{ spec.name } v#{ spec.version }"
  spec.homepage      = 'https://github.com/cookrn/petra'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_dependency 'systemu'

  spec.add_development_dependency 'bundler'  , '~> 1.3'
  spec.add_development_dependency 'minitest' , '> 5.0'
  spec.add_development_dependency 'rake'
end
