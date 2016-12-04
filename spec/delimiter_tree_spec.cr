require "./spec_helper"

describe Delimiter::Tree do

  it "builds a tree" do
    tree = Delimiter::Tree(Symbol).new
    tree.add "/", :root
    tree.find("/").found.should be_true
  end

  it "returns the payload" do
    tree = Delimiter::Tree(Symbol).new
    tree.add "/", :root
    tree.find("/").payload.should eq [:root]
  end

  it "returns an array of payload" do
    tree = Delimiter::Tree(Symbol).new
    tree.add "/", :root
    tree.add "/*", :all_children
    tree.add "/products", :products
    tree.add "/products/*", :all_products
    tree.add "/products/:id", :product
    tree.find("/products/2").payload.should eq [:all_children, :all_products, :product]
  end

  it "supports params" do
    tree = Delimiter::Tree(Symbol).new
    tree.add "/", :root
    tree.add "/:test", :test
    result = tree.find "/1234"
    result.params["test"].should eq "1234"
  end

  it "found? is false if not found" do
    tree = Delimiter::Tree(Symbol).new
    tree.add "/", :root
    tree.add "/products", :products
    tree.add "/products/:id", :product
    result = tree.find "/product"
    result.found?.should be_false
  end

  it "found? is true if found" do
    tree = Delimiter::Tree(Symbol).new
    tree.add "/", :root
    tree.add "/products", :products
    tree.add "/products/:id", :product
    result = tree.find "/products"
    result.found?.should be_true
  end
end
