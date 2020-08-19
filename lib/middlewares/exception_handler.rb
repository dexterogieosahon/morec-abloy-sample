# frozen_string_literal: true

# Rack app for capturing and handling exceptions
class ExceptionHandler

  # Rack app initialization
  # @param app [Object]
  def initialize(app)
    @app = app
  end

  # Rack app call
  # @param env [Hash] (required)
  def call(env)
    @app.call(env)
  rescue Rack::Timeout::RequestTimeoutError => exception
    log_exception(env, exception)
    request_timed_out(exception)
  rescue StandardError => exception
    raise exception unless exception.message == 'DelibrateRuntimeErrorServiceTest'
    log_exception(env, exception)
    internal_error(exception)
  end

  private

  # 408 Request timeout response handler
  # @param exception [Exception] (required)
  # @return [Array]
  def request_timed_out(exception)
    data = error('request_timedout', 'request uncompleted in time.', format_exception(exception))
    [408, hdrs(content_length: data_size(data)), [data]]
  end

  # 500 Internal service error response handler
  # @param exception [Exception] (required)
  # @return [Array]
  def internal_error(exception)
    data = error('internal_error', 'We have been notified.', format_exception(exception))
    [500, hdrs(content_length: data_size(data)), [data]]
  end

  # Prepare response headers
  # @param opts [Hash] (required) header options
  # @return [Hash] response headers
  def hdrs(opts)
    { 'Content-Type' => 'application/json;charset=utf-8', 'Content-Length' => opts[:content_length].to_s }
  end

  # Decodes data size
  # @param data [String] (required) data to find its size
  # @return [String] data size
  def data_size(data)
    data.bytesize.to_s
  end

  # Prepare data hash to string
  # @param opts [Hash] (required) additional data
  # @return [String] json string
  def prepare_data(opts)
    MultiJson.dump(opts)
  end

  # Prepare error response
  # @param code [String] (required) error code
  # @param message [String] (required) error message
  # @param errors [Hash] errors additional data
  # @return [String] json string
  def error(code, message, errors = {})
    data = { error: { code: code, message: message, errors: errors } }
    prepare_data(data)
  end

  # prepare exception data
  # @param exception [Exception] (required)
  # @return [Hash] packaged response
  def format_exception(exception)
    data = {}
    if ENV['RACK_ENV'] == 'development'
      data[:message] = exception.to_s
      data[:backtrace] = exception.backtrace
    end

    data
  end

  # log exception
  # @param env [Hash] (required) Rack env
  # @param [Exception] exception raise Exception
  def log_exception(env, exception)
    env['rack.errors'].puts exception
    env['rack.errors'].puts exception.backtrace.join("\n")
    env['rack.errors'].flush
  end

end
