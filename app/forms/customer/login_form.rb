class Customer::LoginForm
  include ActiveModel::Model

  attr_accessor :email, :password, :remember

  def remember_me?
    remember == '1'
  end
end
