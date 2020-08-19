# frozen_string_literal: true

module OpenApi
  module Shared
    # Namespace for share responses
    module Responses

      # Bad request
      module BadRequestError
        # extend declaration
        def self.extended(base)
          base.response 400 do
            key :description, 'Bad request'
            schema do
              key :'$ref', :Error
            end
          end
        end
      end

      # Shared NotFound Error response
      module NotFoundError
        # extend declaration
        def self.extended(base)
          base.response 404 do
            key :description, 'not found.'
            schema do
              key :'$ref', :Error
            end
          end
        end
      end

    end
  end
end
