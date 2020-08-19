# frozen_string_literal: true

# TEST ENV VARS
ENV['RACK_ENV'] = 'test'

require_relative 'test_helper'

# Load the application
require_relative '../config/boot'

# Load the unit helpers
require_relative 'support/api_helper'

# Load Factories
FactoryGirl.find_definitions

# See http://rubydoc.info/gems/rspec-core/RSpec/Core/Configuration
RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods
  config.include ApiHelper
  config.include JsonSpec::Helpers
  config.include Rack::Test::Methods

  config.around do |example|
     example.run
  end
end
