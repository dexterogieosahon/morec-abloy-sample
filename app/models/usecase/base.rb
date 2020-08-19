# frozen_string_literal: true

# Namespace to capture usecases
module Usecase
  # Usecases base class
  class Base

    # Validates request params against expected json schema
    # @param schema [Object] (required) definition with rules
    # @param data [Hash] (required) options
    # @return [Hash] result from validation or halts and respond with failure
    def self.validate_params(data, schema)
      validator = ::Aux.validate(data, schema)
      return { errors: validator.errors } if validator.failure?
      validator.to_h
    end

    # Generic resource not found handler
    # @param key [String] (required) name of resource identifier key
    # @param value [String] (required)
    # @return [Hash] response
    def self.resource_not_found(key, value)
      { errors: { key.to_sym => ["Invalid #{value}"] } }
    end

  end
end
