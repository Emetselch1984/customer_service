class Admin::LoginForm
  include ActiveModel::Model

  attr_accessor :email, :crypted_password
end
