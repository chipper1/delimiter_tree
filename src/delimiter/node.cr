module Delimiter
  class Node(T)
    getter key
    property payload : T?
    property children

    def initialize(@key : String, @payload : T? = nil)
      @children = {} of String => Node(T)
    end

  end
end
