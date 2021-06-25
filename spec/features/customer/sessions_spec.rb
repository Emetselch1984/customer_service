require 'rails_helper'

feature '顧客ログイン画面' do
  include FeaturesSpecHelper
  let(:customer) { create(:customer) }

  before do
    switch_namespace(:customer)
  end

  scenario 'ログインする' do
    visit customer_login_path
    within('#login-form') do
      fill_in 'メールアドレス', with: customer.email
      fill_in 'パスワード', with: '12345678'
      click_button 'ログイン'
    end
  end
end
