# frozen_string_literal: true

require 'dry-validation'

# Base for all other schema
class BaseSchema < Dry::Validation::Schema

  configure do
    option :params, {}
  end

  # Error message to return
  def self.messages
    Dry::Validation::Messages.default.merge(
      en: {
        errors: {
          regmatch?: 'is invalid',
          pos_int?: 'is not a valid integer'
        }
      }
    )
  end

  # Validate is against regex
  # @param opts [Hash] (required)
  # @param value [String] (required) value
  # @return [Boolean] check result
  def regmatch?(opts, value)
    value.to_s =~ opts[:regex]
  end

  # Check whether a value looks like a positive integer
  # @param value [String] Value to check
  # @return [Boolean] Good value
  def pos_int?(value)
    return false unless value.is_a?(Integer) || value.is_a?(String)
    return false if value.to_s.empty?
    Integer(value).positive?
  rescue ArgumentError
    false
  end

end

# Base for all other list schema
class ListBaseSchema < BaseSchema

  define! do
    optional(:page).filled(:pos_int?)
    optional(:page_size).filled(:pos_int?)
  end

end

# Base for all other find schema
class FindBaseSchema < BaseSchema

  define! do
    
  end

end
