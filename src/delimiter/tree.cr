require "./node"
require "./result"

module Delimiter
  class Tree(T)
    getter :root

    def initialize(@delimiter = "/")
      @root = Node.new("")
    end
    
    def add(path : String, payload)
      pos = @root
      parts = path.split(@delimiter)
      parts.each do |key|
        unless pos.children.has_key? key
          pos.children[key] = Node.new(key)
        end
        pos = pos.children[key]
      end
      pos.payload = payload
    end

    def find(path : String)
      result = Result(T).new
      
      pos = @root
      parts = path.split(@delimiter)
      parts.each do |part|
        @found = false
        if pos.children.has_key? "*"
          result.payload << pos.children["*"].payload
        end
        if pos.children.has_key? part
          @found = true
          pos = pos.children[part]
        else
          #might be a better way to do this
          pos.children.each_key do |key|
            if key.starts_with? ":"
              result.params[key.sub(":", "")] = part
              pos = pos.children[key]
              @found = true
            end
          end
        end
      end
      result.found = @found
      result.payload << pos.payload if @found
      result
    end
  end
end
