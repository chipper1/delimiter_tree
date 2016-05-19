module Delimiter
  class Node
    getter :key
    property :payload
    property :children

    def initialize(@key : String, @payload : Symbol? = nil)
      @children = {} of String => Node
    end

  end
end
