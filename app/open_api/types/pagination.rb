# frozen_string_literal: true

module OpenApi
  module Types
    # OpenApi Pagination declaration
    class Pagination

      include Swagger::Blocks

      swagger_schema :Pagination do
        key :required, %i[pagination]
        property :pagination do
          key :required, %i[page_size page next_page prev_page
                            total_pages total_count]
          key :type, :object
          property :page_size do
            key :example, 20
            key :type, :integer
            key :maximum, 3500
          end
          property :page do
            key :example, 2
            key :type, :integer
          end
          property :next_page do
            key :example, 3
            key :type, :integer
          end
          property :prev_page do
            key :example, 1
            key :type, :integer
          end
          property :total_pages do
            key :example, 10
            key :type, :integer
          end
          property :total_count do
            key :example, 200
            key :type, :integer
          end
        end
      end

    end
  end
end
