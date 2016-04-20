class Customer
  attr_reader :name
  @@customers = []

  def initialize(options = {})
    @name = options[:name]
    add_to_customers
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
