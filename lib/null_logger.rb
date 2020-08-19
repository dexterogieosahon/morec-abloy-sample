# frozen_string_literal: true

require 'logger'

# Null logger
class NullLogger < Logger

  # instantiation
  def initialize
    super('/dev/null')
  end

end
