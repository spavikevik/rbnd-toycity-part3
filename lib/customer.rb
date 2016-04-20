require 'date'
class Customer
  attr_reader :name, :email
  @@customers = []

  def initialize(options = {})
    @name = options[:name]
    @email = options[:email]
    add_to_customers
  end

  def purchase(product)
    if product.in_stock?
      Transaction.new(self, product)
      send_invoice(product.title)
    else
      raise OutOfStockError, "'#{product.title}' is out of stock."
    end
  end

  def return(product)
    if (Transaction.find_by_customer_and_product(self, product).date - Date.today).to_i < 90
      Transaction.return(self, product)
    else
      raise ReturnPeriodEndedError
    end
  end

  def send_invoice(product_title) # Dummy method for sending e-mail invoices
    puts "\n---------------\nTo: #{email}\nHello #{name}, \nThank you for purchasing #{product_title}.\nYours,\nToyCity!"
  end

  def self.all
    @@customers
  end

  def self.find_by_name(name)
    @@customers.find {|cust| cust.name == name}
  end

  private

  def add_to_customers
    if @@customers.index {|cust| cust.name == self.name}
      raise DuplicateCustomerError, "'#{self.name}' already exists."
    else
      @@customers << self
    end
  end

end
