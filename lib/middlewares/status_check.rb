# frozen_string_literal: true

# A Rack middleware for status check
class StatusCheck

  # initialize rack app
  # @param app [Object]  (required)
  # @param block [Object] (required)
  def initialize(app, &block)
    @app = app
    @block = block
  end

  # trigger app
  # @param env [Hash] (required)
  def call(env)
    if env['PATH_INFO'] == '/status'
      result = instance_eval(&@block) ? 'PASSED!' : 'FAILED!'
      [200, { 'Content-Type' => 'text/plain' }, [result]]
    else
      @app.call(env)
    end
  end

end
