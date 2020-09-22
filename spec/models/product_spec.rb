require 'rails_helper'

RSpec.describe Product, type: :model do

  describe "check positive outputs" do
    before (:each) do
      @category = Category.new(name: "category1")
      @product = @category.products.new(name: "test1", price_cents: 66666, quantity: 3, category: @category)
    end

    it "should create a new product with a name" do
      # @product = @category.products.new(name: "test1")
      expect(@product.name).to eq("test1")
    end

    it "should create a new product with a specific price_cents value" do
      # @product = @category.products.new(name: "test1")
      expect(@product.price_cents).to eq(66666)
    end

    it "should create a new product with a specific quantity" do
      # @product = @category.products.new(name: "test1")
      expect(@product.quantity).to eq(3)
    end

    it "should create a new product with the category declared above" do
      # @product = @category.products.new(category: @category)
      expect(@product.category).to eq(@category)
    end
  end

  describe "validations" do
    before (:each) do
      @category = Category.new(name: "test")
    end

    it "should flag name can't be blank" do
      @product = @category.products.new(name: nil, price_cents: 66666, quantity: 3, category: @category)
      @product.save
      # @product.valid?
      expect(@product.errors.full_messages).to include("Name can't be blank")
    end

    it "should flag Price cents is not a number" do
      @product = @category.products.new(price_cents: "test")
      @product.valid?
      expect(@product.errors.full_messages).to include("Price cents is not a number")
    end

    it "should flag Quantity can't be blank" do
      @product = @category.products.new
      @product.valid?
      expect(@product.errors.full_messages).to include("Quantity can't be blank")
    end

    it "should flag Price is not a number" do
      @product = @category.products.new(price: "test")
      @product.valid?
      expect(@product.errors.full_messages).to include("Price is not a number")
    end

    it "should flag Price can't be blank" do
      @product = @category.products.new
      @product.valid?
      expect(@product.errors.full_messages).to include("Price can't be blank")
    end
  end

end

["Price is not a number", "Price can't be blank", "Quantity can't be blank"]