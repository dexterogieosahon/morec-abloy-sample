# frozen_string_literal: true

require 'opentracing'
require 'jaeger/client'
require 'rack/tracer'

require_relative './config/boot'

tracing_and_logging = proc { |builder|
  if ENV['RACK_ENV'] != 'test'
    builder.use Rack::FeaLogger
    builder.use Rack::Tracer,
                on_start_span: ->(span) { Thread.current[:root_span] = span },
                on_finish_span: ->(_span) { Thread.current[:root_span] = nil }

  end
}

use RequestTimer
use RequestId
use ExceptionHandler

Rack::Timeout::Logger.disable
use BodyParser
use Rack::Timeout, service_timeout: 20
use StatusCheck do
  DB.test_connection
end

map('/') { run Api::Controllers::Main }
