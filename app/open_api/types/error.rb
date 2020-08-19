# frozen_string_literal: true

# Namespace for OpenApi modules and classes
module OpenApi
  # Namespace for OpenApi Types
  module Types
    # OpenApi Error declaration
    class Error

      include Swagger::Blocks

      swagger_schema :Error do
        key :required, %i[error]
        property :error do
          key :required, %i[code message]
          key :type, :object
          property :code do
            key :type, :string
            key :example, 'error_code'
          end
          property :message do
            key :type, :string
            key :example, 'Error message.'
          end
          property :errors do
            key :type, :object
            property :name do
              key :type, :array
              items do
                key :type, :string
                key :example, 'requirement not met.'
              end
            end
          end
        end
      end

    end
  end
end
