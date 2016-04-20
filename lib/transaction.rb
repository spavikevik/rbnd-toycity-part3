require 'date'
class Transaction
  attr_reader :product, :customer, :date
  @@transactions = []
  @@returns = []

  def initialize(customer, product)
    @customer = customer
    @product = product
    @date = Date.today
    add_to_transactions
  end

  def id
    @@transactions.index(self).to_i + 1
  end

  def self.list_returns
    @@returns
  end

  def self.all
    @@transactions
  end

  def self.find(id)
    @@transactions[id-1]
  end

  def self.find_by_customer_and_product(customer, product)
    @@transactions.find {|trans| trans.customer == customer && trans.product == product}
  end

  def self.return(customer, product)
    @@returns << find_by_customer_and_product(customer, product)
    @@transactions.delete_if {|trans| trans.customer == customer && trans.product == product}
  end

  private

  def add_to_transactions
    @@transactions << self
  end
end
