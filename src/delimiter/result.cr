module Delimiter
  class Result
    getter params
    property payload
    property found

    def initialize
      @params = {} of String => String
      @payload = nil
      @found = false
    end

    def found?
      @found
    end

  end
end
