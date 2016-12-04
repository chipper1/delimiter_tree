# Delimiter Tree

A delimiter tree is a tree that is built from a string based on the delimiter.
For example, if you have a string "foo;bar" then you will have a parent node
"foo" and a child node "bar".  Each node will hold a payload. 

The delimiter tree also supports two special characters.
- : is used for a parameter
- * is used to include a payload for all children nodes

The tree will return an array of payloads for all matching * as well
as the specific payload for the final matching string.



## Installation

Add this to your application's `shard.yml`:

```yaml
dependencies:
  delimiter_tree:
    github: drujensen/delimiter_tree
```

## Usage

The delimiter tree is used to return a payload or an array of payloads for a
particular delimited string.  This can be used for url paths or any situation
where you need to specifically hold data per each segment of a delimited
string.

```crystal
require "delimiter_tree"

tree = Delimiter::Tree.new("/")
tree.add "/*", :all_children
tree.add "/products", :products
tree.add "/products/:id", :specific_product

result = tree.find "/products/2"

puts result.payload
# [:all_children, :products]

puts result.params
# :id => 2

```

## Contributing

1. Fork it ( https://github.com/drujensen/delimiter_tree/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request

## Contributors

- [drujensen](https://github.com/drujensen) Dru Jensen - creator, maintainer
