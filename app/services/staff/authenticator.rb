class Staff::Authenticator
  def initialize(staff)
    @staff = staff
    @current_password = nil
  end

  def authenticate
    @staff &&
      !@staff.suspended? &&
      @staff.start_date <= Date.today &&
      (@staff.end_date.nil? || @staff.end_date > Date.today)
  end
end
