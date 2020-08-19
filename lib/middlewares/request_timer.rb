# frozen_string_literal: true

# A Rack middleware for timing the request and response.
class RequestTimer

  # initialize rack app
  # @param app [Object] (required)
  def initialize(app)
    @app = app
  end

  # trigger app
  # @param env [Hash] (required)
  # @return [Array]
  def call(env)
    start = Time.current
    status, headers, body = @app.call(env)

    headers['Elapsed'] = "#{(Time.current - start).to_f} seconds"
    [status, headers, body]
  end

end
