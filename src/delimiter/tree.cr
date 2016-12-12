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
      last_pos = pos

      parts = path.split(@delimiter)
      parts.each do |part|
        if pos.children.has_key?("*") 
          pos.children["*"].payload.each {|p| result.payload << p}
        end
        
        if pos.children.has_key? part
          pos = pos.children[part]
        else
          pos.children.each_key do |key|
            if key.starts_with? ":"
              result.params[key.sub(":", "")] = part
              pos = pos.children[key]
            end
          end
        end

        pos == last_pos ?  break :(last_pos = pos)
      end
      pos.payload.each {|p| result.payload << p}
      result.found = !result.payload.empty?
      result
    end
  end
end
