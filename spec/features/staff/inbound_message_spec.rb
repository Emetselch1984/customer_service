require 'rails_helper'

feature '職員の受信メッセージ画面' do
  include FeaturesSpecHelper
  let(:staff) { create(:staff) }
  let(:customer) { create(:customer) }
  let(:args) do
    {
      subject: 'これは問い合わせです。' * 4,
      body: "これは問い合わせです。\n" * 8
    }
  end
  let(:messages) { Message.all }

  before do
    switch_namespace(:staff)
    login_as_staff(staff)
    customer.outbound_messages.create(args)
  end

  scenario '受信メッセージ画面の表示' do
    click_link '問い合わせ一覧'
    expect(current_path).to eq inbound_staff_messages_path
    expect(page).to have_content '新規問い合わせ(1)'
    expect(page).to have_content '山田 太郎'
    expect(page).to have_content 'これは問い合わせです。'
  end
  scenario 'メッセージ詳細画面の表示' do
    click_link '問い合わせ一覧'
    first('td.actions').click_link '詳細'
    expect(current_path).to eq staff_message_path(CustomerMessage.last)
    expect(page).to have_content 'メッセージ詳細'
    expect(page).to have_content '山田 太郎'
  end
end
