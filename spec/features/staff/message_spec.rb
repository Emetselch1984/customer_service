require 'rails_helper'

feature '職員による問い合わせ機能' do
  include FeaturesSpecHelper
  let(:staff) { create(:staff) }
  let(:customer) { create(:customer) }
  let(:args) {
    {
      subject:  'これは問い合わせです。' * 4,
      body: "これは問い合わせです。\n" * 8,
    }
  }

  before do
    switch_namespace(:staff)
    login_as_staff(staff)
    new_message = customer.outbound_messages.create(args)
  end

  scenario '受信メール一覧' do
    click_link '問い合わせ一覧'
    expect(current_path).to eq inbound_staff_messages_path
    expect(page).to have_content '山田 太郎'
    expect(page).to have_content 'これは問い合わせです。'

  end
end