# frozen_string_literal: true

FileList.new(
  File.join(
    ROOT_DIR, 'app', 'open_api', 'api_definitions', '*.rb'
  )
).exclude(/main/).uniq.each { |rb| require rb }

# Namespace for OpenAPI
module OpenApi
  # Namespace for API definitions
  module ApiDefinitions
    # OpenAPI declaration
    class Main

      include Swagger::Blocks

      swagger_root do
        key :swagger, '2.0'
        info do
          key :version, '1.0.0'
          key :title, 'Movie recommendation API Service'
          key :description, 'Movie recommendation API Service.'

          contact do
            key :name, 'Dexter Ogie-osahon'
            key :email, 'dexter.ogie-osahon@live.com'
            key :url, 'http://www.moviereco.com'
          end
        end
        key :host, ENV.fetch('SERVICE_URI', 'localhost:8080').to_s
        key :basePath, '/'
        key :schemes, %w[http https]
        key :consumes, ['application/json']
        key :produces, ['application/json']
        %w[sample].each do |tag_name|
          tag do
            key :name, tag_name
          end
        end
      end

      # Generates OpenAPI API definition
      # @return [Hash] API definition
      def self.docs
        Swagger::Blocks.build_root_json([
          ::OpenApi::Types::Error,
          ::OpenApi::Types::Pagination,
          self
        ])
      end

    end
  end
end
