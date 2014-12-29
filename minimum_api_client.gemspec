$:.unshift File.expand_path('../lib', __FILE__)
require 'minimum_api_client/version'

Gem::Specification.new do |s|
  s.authors               = 'alpaca-tc'
  s.date                  = Time.now.strftime('%Y-%m-%d')
  s.email                 = 'alpaca-tc@alpaca.tc'

  s.files                 = `git ls-files -- lib/*`.split("\n")
  s.files                += %w[LICENSE README.md]

  s.homepage              = 'https://github.com/alpaca-tc/minimum_api_client'
  s.license               = 'MIT'
  s.name                  = 'minimum_api_client'
  s.require_paths         = ['lib']
  s.required_ruby_version = '>= 2.0.0'
  s.version               = MinimumApiClient::VERSION

  s.summary               = ''
  s.description           = ''

  s.add_dependency 'faraday'
  s.add_dependency 'faraday_middleware'
  s.add_dependency 'activesupport'
end
