class Product
  attr_reader :title, :price, :stock

  @@products = []

  def initialize(options = {})
    @title = options[:title]
    @price = options[:price]
    @stock = options[:stock]
    add_to_products
  end

  def in_stock?
    stock > 0 ? true : false
  end

  def self.all
    @@products
  end

  def self.in_stock
    @@products.select {|prod| prod.in_stock?}
  end

  def self.find_by_title(title)
    @@products.find {|prod| prod.title == title}
  end

  private

  def add_to_products
    if @@products.index {|prod| prod.title == self.title}
      raise DuplicateProductError, "#{self.title} already exists."
    else
      @@products << self
    end
  end
end
