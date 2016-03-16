module Delimiter
  class Result(T)
    getter params
    property payload
    property found

    def initialize
      @params = {} of String => String
      @payload = [] of T
      @found = false
    end

    def found?
      @found
    end

  end
end
