# frozen_string_literal: true

require 'multi_json'

module ApiHelper
  # Extracts the status from the response
  # @return [Integer] HTTP response code
  def response_status
    last_response.status
  end

  # Extracts the headers from the response
  # @return [Hash] HTTP response headers
  def response_headers
    last_response.header
  end

  # Extracts data part of response body
  # @return [Hash] json hash
  def response_data
    response_body[:data]
  end

  # Decode json string to hash
  # @return [Hash] parsed response body
  def response_body
    ::Aux.j2hash(last_response.body)
  end

  # Extracts pagination part of response body meta
  # @return [Hash] json hash
  def response_pagination
    response_body[:meta][:pagination]
  end
end
