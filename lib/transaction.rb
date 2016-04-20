class Transaction
  attr_reader :product, :customer
  @@transactions = []

  def initialize(customer, product)
    @customer = customer
    @product = product
    add_to_transactions
  end

  def id
    @@transactions.index(self).to_i + 1
  end

  def self.all
    @@transactions
  end

  def self.find(index)
    @@transactions[index-1]
  end

  private

  def add_to_transactions
    @@transactions << self
  end
end
