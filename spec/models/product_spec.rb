require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    # validation tests/examples here
    it "is valid" do
      @furniture = Category.new
      @furniture.name = 'Sofa'
      @product = Product.new
      @product.name = 'Example'
      @product.price_cents = 123
      @product.quantity = 5
      @product.category = @furniture
      expect(@product.valid?).to be true
    end

    it "name, presence" do
      @product = Product.new
      @product.name = nil
      @product.name = "Chair"
      @product.valid?
      expect(@product.errors[:name]).not_to  include("cannot be blank")
    end

    it "price, presence" do
      @product = Product.new
      @product.price = nil
      @product.price_cents = 123456
      @product.valid?
      expect(@product.errors[:price_cents]).not_to  include("cannot be blank")
    end

    it "quantity, presence" do
      @product = Product.new
      @product.quantity = nil
      @product.quantity = 15
      @product.valid?
      expect(@product.errors[:quantity]).not_to  include("cannot be blank")
    end

    it "category, presence" do
      @furniture = Category.new
      @product = Product.new
      @product.category = nil
      @product.category = @furniture
      @product.valid?
      expect(@product.errors[:category]).not_to  include("cannot be blank")
    end


  end


end
