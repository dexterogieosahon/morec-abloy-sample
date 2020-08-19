# frozen_string_literal: true

module Api
  # Namespace for controller classes as request handlers
  module Controllers
    # Application base class provides application-wide common setup.
    class Base < ::Sinatra::Base

      helpers ::Api::Helpers::Errors
      helpers ::Api::Helpers::Request
      helpers ::Api::Helpers::Response

      set :root, ROOT_DIR
      set :server, :puma
      set :json_encoder, MultiJson

      configure do
        enable :raise_errors
        enable :logging unless test?
        disable :dump_errors, :show_exceptions, :static
      end

      before { content_type(:json) }

      error Sinatra::NotFound do
        code = 'unknown_endpoint'
        message = "Endpoint '#{request.request_method} - " \
                  "#{request.path_info}' not found."
        halt_not_found(code, message)
      end

      # Reads in api version doc
      # @return [String] json string
      def version_info
        halt 200, File.read("#{ROOT_DIR}/VERSION.json")
      rescue StandardError
        halt_not_found('no_version_definition',
                       'No API version documentation at this time.')
      end

      # Reads in request headers
      # @return [Hash] request headers
      def request_headers
        hdrs ||= Hash[
          *env.select { |k, _| k.start_with?('HTTP_') || (k == 'CONTENT_TYPE') }
             .map { |k, v| [k.sub(/^HTTP_/, ''), v] }
             .map { |k, v| [k.split('_').collect(&:capitalize).join('-'), v] }
             .sort.flatten
        ]
        hdrs
      end

    end
  end
end
