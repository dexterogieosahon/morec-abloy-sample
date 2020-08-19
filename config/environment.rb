# frozen_string_literal: true
# encoding: UTF-8

# Add current path and lib to the load path
$LOAD_PATH << File.expand_path('../', __dir__)
$LOAD_PATH << File.expand_path('../lib', __dir__)

# ENV or default to dev
ENV['RACK_ENV'] ||= 'development'

# load gems from the Gemfile
require 'bundler'
Bundler.require(:default)

# load dev env vars
if %w[development test].include?(ENV['RACK_ENV'])
  require 'dotenv' unless defined?(Dotenv)
  Dotenv.load(".env.#{ENV['RACK_ENV']}")
end

ROOT_DIR = File.dirname(__dir__).freeze

# load additional libs
require 'active_support/core_ext/object/blank'     # provides blank? and present?
require 'active_support/core_ext/integer/time'     # provides 1.day.ago etc
require 'active_support/core_ext/hash/slice'       # provides params.slice(:one, :other)
require 'active_support/core_ext/hash/conversions' # provides params.symbolize_keys
require 'active_support/core_ext/string/inflections' # provides ''.constantize
require 'active_support/core_ext/hash/keys' # deep_transform_keys camelCase => snake_case
require 'active_support/core_ext/hash/indifferent_access' # hash_with_indifferent_access

# load initializers
require_relative './initializers/object'
require_relative './initializers/hash'
require_relative './initializers/multi_json'
require_relative './initializers/config'
