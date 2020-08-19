# frozen_string_literal: true

module Api
  module Helpers
    # Namespace for response helpers.
    module Response
      # Wraps a hash used in a success response body
      # @param data [Object] data to wrap
      # @param opts [Hash] optional data
      # @return [String] wrapped json string
      def ok(data, opts = {})
        data = { data: data }
        data = data.merge(meta: opts) if opts.keys.any?
        ::Aux.h2json(data)
      end

      # Wraps a hash used in a fail response body
      # @param code [String] error code
      # @param hash [Hash] hash to wrap
      # @param opts [Hash] optional data
      # @return [String] wrapped json string
      def err(code, hash, opts = {})
        error = { error: hash.merge(code: code) }
        error = error.merge(meta: opts) if opts.keys.any?
        ::Aux.h2json(error)
      end
    end
  end
end
