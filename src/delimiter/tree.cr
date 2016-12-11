require "./node"
require "./result"

module Delimiter
  class Tree(T)
    property root : Node(T)
    property delimiter : String

    def initialize(@delimiter : String = "/")
      @root = Node(T).new("")
    end

    def add(path : String, payload : T)
      pos = @root
      parts = path.split(@delimiter)
      parts.each do |key|
        unless pos.children.has_key? key
          pos.children[key] = Node(T).new(key)
        end
        pos = pos.children[key]
      end
      pos.payload << payload
    end

    def find(path : String)
      result = Result(T).new

      pos = @root
      parts = path.split(@delimiter)
      parts.each do |part|
        @found = false
        if pos.children.has_key? "*"
          pos.children["*"].payload.each {|p| result.payload << p}
          @found = !result.payload.empty?
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
      result.found = (@found == true)
      pos.payload.each {|p| result.payload << p}
      result
    end
  end
end
