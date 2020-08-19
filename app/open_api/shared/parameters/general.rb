# frozen_string_literal: true

module OpenApi
  # Namespace for shared modules
  module Shared
    # Namespace for shared parameters
    module Parameters
      # Shared List start page parameter
      module ListStartPage
        # extend declaration
        def self.extended(base)
          base.parameter do
            key :name, :page
            key :in, :query
            key :description, 'starting page to return results from.'
            key :required, false
            key :type, :integer
            key :format, :int32
          end
        end
      end

      # Shared List page size parameter
      module ListPageSize
        # extend declaration
        def self.extended(base)
          base.parameter do
            key :name, :page_size
            key :in, :query
            key :description, 'maximum number of results to return. ' \
                              'currently no more than 3500'
            key :required, false
            key :type, :integer
            key :format, :int32
            key :maximum, 3500
          end
        end
      end
    end
  end
end
