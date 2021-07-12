class Customer::EntryAcceptor
  def initialize(customer)
    @customer = customer
  end

  def accept(program)
    ActiveRecord::Base.transaction do
      program.lock!
      if program.entries.where(user_id: @customer.id).exists?
        return :accepted
      end
    end
  end
end
