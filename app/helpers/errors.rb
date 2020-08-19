# frozen_string_literal: true

# Namespace for api
module Api
  # Namespace for api helpers.
  module Helpers
    # Namespace for error helpers.
    module Errors
      # Fallback Handler responding to bad request
      # Primary handler is body_parser middleware
      # @param code [String] error code
      # @param message [String] error message
      # :nocov:
      def halt_bad_request(code, message)
        halt 400, err(code, message: message)
      end
      # :nocov:

      # Handler responding to insufficient privileges
      # @param code [String] error code
      # @param message [String] error message
      def halt_unauthorised(code, message)
        halt 401, err(code, message: message)
      end

      # Handler responding to server having not found
      # anything matching the Request-URI or resource
      # @param code [String] error code
      # @param message [String] error message
      def halt_not_found(code, message)
        halt 404, err(code, message: message)
      end

      # Handler responding to invalid request
      # @param code [String] error code
      # @param errors [Hash] hash of errors
      # @param [String] message error message
      def halt_unprocessable_entity(code, errors,
                                    message = 'Validation failed.')
        halt 422, err(code, message: message, errors: errors)
      end

      # Fallback Handler responding to server error
      # @param exception [String] error message
      # Primary handler is exception_handling middleware
      # :nocov:
      def halt_internal_server_error(exception = 'internal_server_error')
        ::Aux.notify(exception, request)
        code = 'internal_server_error'
        halt 500, err(code, message: 'Internal server error: ' \
                                     'we have been notified of the issue.')
      end
      # :nocov:
    end
  end
end
