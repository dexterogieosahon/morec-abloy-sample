# frozen_string_literal: true

module Usecase
  # Usecases class
  class Movie < Base

    # Recommend movie by genre.
    # @option opts [Hash] Product parent organization
    # @option opts [String] :genre
    # @return [Hash] recommendations
    def self.recommendations(opts)
      result = ::RecommendEngine.recommend(opts[:genre])
      { data: result }
    end

  end
end
