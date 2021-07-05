module FeaturesSpecHelper
  def switch_namespace(namespace)
    config = Rails.application.config.system_service
    Capybara.app_host = "http://#{config[namespace][:host]}"
  end

  def login_as_staff(staff, password = '12345678')
    visit staff_login_path
    within('#login-form') do
      fill_in 'メールアドレス', with: staff.email
      fill_in 'パスワード', with: password
      click_button 'ログイン'
    end
  end
  def login_as_customer(customer, password = '12345678')
    visit customer_login_path
    within('#login-form') do
      fill_in 'メールアドレス', with: customer.email
      fill_in 'パスワード', with: password
      click_button 'ログイン'
    end
  end
end
