# frozen_string_literal: true

# A Rack middleware for parsing POST/PUT body data when Content-Type is
# not one of the standard supported types, like <tt>application/json</tt>.
class BodyParser

  # form_input Constant
  FORM_INPUT = 'rack.request.form_input'
  # form_hash Constant
  FORM_HASH = 'rack.request.form_hash'

  # Supported Content-Types
  APPLICATION_JSON = 'application/json'

  # initialize rack app
  # @param app [Object] (required)
  def initialize(app)
    @app = app
  end

  # trigger app
  # @param env [Hash] (required)
  def call(env)
    request = Rack::Request.new(env)
    body = request.body.read
    request.body.rewind

    if body.length.positive?
      result = nil
      begin
        result = MultiJson.load(body)
      rescue MultiJson::ParseError => exception
        return halt_bad_request('invalid_json', { cause: [exception.cause] }, 'Invalid JSON payload.')
      end

      env.update(FORM_HASH => result, FORM_INPUT => request.body)
    end
    @app.call(env)
  end

  private

  # bad request response handler
  # @param code [String] (required) error code
  # @param errors [Hash] (required) hash of errors
  # @param message [String] message error message
  # @return [Array] response object
  def halt_bad_request(code, errors, message = 'Bad request')
    data = MultiJson.dump(error: { code: code, message: message, errors: errors })
    size = data.bytesize.to_s
    [
      400,
      { 'Content-Type' => 'application/json;charset=utf-8', 'Content-Length' => size },
      [data]
    ]
  end

end
