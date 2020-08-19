# frozen_string_literal: true

# Class Object
class Object

  # cast to boolean
  # @return [Boolean] boolean value of self or error
  def to_b
    return true  if self == true   || self =~ Aux.regex_for_true
    return false if self == false  || blank? || self =~ Aug.regex_for_false
    raise ArgumentError, "invalid value for Boolean: \"#{self}\""
  end

end
