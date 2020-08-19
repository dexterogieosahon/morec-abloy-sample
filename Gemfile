# frozen_string_literal: true

source 'https://rubygems.org'

gem 'activesupport', '5.0.2', require: 'active_support'

gem 'dry-validation', '~> 0.11.1'
gem 'multi_json', '~> 1.12'
gem 'oj', '~> 3.0'

gem 'puma', '~> 3.9'

gem 'rack', '~> 2.0.3'
gem 'rack-timeout', '~> 0.4.2'
gem 'rake', '~> 12.0'

gem 'sinatra', '~> 2.0.1', require: 'sinatra/base'
gem 'sinatra-contrib'
gem 'swagger-blocks', '~> 2.0.2'

gem 'dotenv', '~> 2.2', require: false

gem 'jaeger-client', '~> 0.4'
gem 'opentracing', '~> 0.3'
gem 'rack-tracer', '~> 0.5'

gem 'sysrandom'

group :development do
  gem 'rerun'
  gem 'yard', ['>= 0.9.11', '< 1']
end

group :development, :test do
  gem 'bundler-audit', '~> 0.5.0', require: false
  gem 'fakefs', '~> 0.11.2', require: false
  gem 'guard', '~> 2.14.1'
  gem 'guard-cucumber', '~> 2.1.2'
  gem 'guard-rspec', '~> 4.7.3', require: false
  gem 'pry'
  gem 'rspec', '~> 3.6'
  gem 'rspec-collection_matchers'
  gem 'rubocop', '>= 0.52.1', require: false
  gem 'rubocop-rspec', '~> 1.23'
  gem 'terminal-notifier', '~> 1.7.1'
  gem 'terminal-notifier-guard', '~> 1.7.0'
  gem 'webmock', '~> 3.0.1'
end

group :test do
  gem 'cucumber', '~> 2.4.0'
  gem 'factory_girl', '~> 4.8.0'
  gem 'faker', '~> 1.7.3'
  gem 'json_spec', '~> 1.1.5'
  gem 'mustache', '~> 1.0'
  gem 'rack-test', '~> 0.6.3'
  gem 'simplecov', '~> 0.14', require: false
end
