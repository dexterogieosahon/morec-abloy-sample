# frozen_string_literal: true

ENV['RACK_ENV'] = 'test'

require 'rack/test'
require 'factory_girl'
require 'faker'
require 'rspec/expectations'
require 'rspec/support/differ'
require 'rspec/matchers/built_in/eq'
require 'rspec/matchers/built_in/eql'
require 'rspec/matchers/built_in/be_kind_of'
require 'rspec/matchers/built_in/include'
require 'rspec/matchers/built_in/match'
require_relative '../../spec/support/api_helper'
require 'mustache'
require 'json_spec/cucumber'
require 'simplecov'
require 'webmock/cucumber'
require 'rspec/collection_matchers'

WebMock.disable_net_connect!(allow_localhost: true)

SimpleCov.start do
  command_name 'cucumber features'

  add_filter 'config/'
  add_filter 'db/'
  add_filter 'docker/'
  add_filter 'features/'
  add_filter 'lib/tasks/'

  add_group 'Helpers', 'app/helpers/'
  add_group 'Models', 'app/models/'
  add_group 'Controllers', 'app/controllers/'
end

# Load app
require_relative '../../config/environment'
APP = Rack::Builder.parse_file(File.expand_path(File.join(__dir__, '..', '..', 'config.ru'))).first

# Load Factories
Dir[File.join(ROOT_DIR, 'spec', 'factories', '**', '*.rb')].each { |f| require f }

# AppWorld
class AppWorld

  include RSpec::Expectations
  include RSpec::Matchers
  include Rack::Test::Methods
  include ApiHelper
  include FactoryGirl::Syntax::Methods

  def app
    APP
  end

end

World do
 AppWorld.new
end

# Do something after each scenario.
After do
  
end
