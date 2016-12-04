module Delimiter
  class Node(T)
    getter key
    property payload
    property children

    def initialize(@key : String, @payload = [] of T)
      @children = {} of String => Node(T)
    end
  end
end
