# frozen_string_literal: true

module Api
  module Helpers
    # Namespace for request helpers.
    module Request
      # Overrides and enriches request params
      # @return [Hash] request params
      def params
        super.with_indifferent_access
      end
    end
  end
end
