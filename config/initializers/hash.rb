# frozen_string_literal: true

# Class Hash
class Hash

  # use string Hash keys
  # @return [Hash]
  def skeys
    hash = reduce({}) do |hsh, (key, value)|
      hsh.merge(key.to_s => value)
    end
    hash
  end

end
