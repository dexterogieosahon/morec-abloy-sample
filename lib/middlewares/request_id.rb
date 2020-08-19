# frozen_string_literal: true

# A Rack middleware for ensuring Request-ID
class RequestId

  # HTTP_REQUEST_ID Constant
  HTTP_REQUEST_ID = 'HTTP_REQUEST_ID'
  # Request-Id Constant
  REQUEST_ID = 'Request-Id'

  # initialize rack app
  # @param app [Object] (required)
  def initialize(app)
    @app = app
  end

  # trigger app
  # @param env [Hash] (required)
  def call(env)
    request_id = ensure_request_id(env[HTTP_REQUEST_ID])[0..254]
    env[HTTP_REQUEST_ID] = request_id

    @app.call(env).tap { |_status, headers, _body| headers[REQUEST_ID] = request_id }
  end

  private

  # generate request id unless present
  # @param request_id [String] (required) The request Id
  # @return [String] request Id given or generated
  def ensure_request_id(request_id)
    request_id = request_id.to_s.gsub(/[^\w\-]/, '')
    request_id.length.positive? ? request_id : Sysrandom.uuid
  end

end
