class Customer::Authenticator
  def initialize(customer)
    @customer = customer
  end

  def authenticate
    @customer &&
      !@customer.suspended? &&
      @customer.start_date <= Date.today &&
      (@customer.end_date.nil? || @customer.end_date > Date.today)
  end
end
