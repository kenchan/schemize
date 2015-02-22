# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'schemize/version'

Gem::Specification.new do |spec|
  spec.name          = 'schemize'
  spec.version       = Schemize::VERSION
  spec.authors       = ['Kenichi TAKAHASHI']
  spec.email         = ['kenichi.taka@gmail.com']
  spec.summary       = %q{Generate JSON Schema from your JSON documents.}
  spec.homepage      = 'http://github.com/kenchan/schemize'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_dependency 'thor'
  spec.add_dependency 'activesupport'

  spec.add_development_dependency 'bundler', '~> 1.7'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'test-unit'
  spec.add_development_dependency 'pry'
end
