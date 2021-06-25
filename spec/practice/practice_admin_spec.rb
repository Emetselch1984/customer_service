require 'rails_helper'
describe 'routes', type: :routing do
  it '管理人トップページ' do
    config = Rails.application.config.system_service
    url = "http://#{config[:admin][:host]}/#{config[:admin][:path]}"
    expect(get(url)).to route_to(
      host: config[:admin][:host],
      controller: 'admin/top',
      action: 'index'
    )
  end
end
feature '管理人ログイン画面' do
  let(:admin) { create(:admin) }
  before do
    config = Rails.application.config.system_service
    Capybara.app_host = "http://#{config[:admin][:host]}"
  end
  scenario '管理人としてログインする' do
    visit admin_login_url
    fill_in 'メールアドレス', with: admin.email
    fill_in 'パスワード', with: '12345678'
    click_button 'ログイン'
    expect(page).to have_selector '.notice', text: 'ログインしました'
    expect(current_path).to eq admin_root_path
  end
  scenario '空欄でログインする' do
    visit admin_login_url
    click_button 'ログイン'
    expect(page).to have_selector '.alert', text: 'メールまたはアドレスが正しくありません。'
  end
end
describe 'ログイン前', type: :request do
  describe '#index' do
    config = Rails.application.config.system_service
    it 'ログインフォームにリダイレクト' do
      get url_for(
        {
          host: config[:admin][:host],
          controller: 'admin/top',
          action: :index
        }
      )
      expect(response).to redirect_to admin_login_url
    end
  end
end
describe 'ログイン後', type: :request do
  let(:admin) { create(:admin) }
  before do
    post admin_login_url,
         params: {
           admin_login_form: {
             email: admin.email,
             password: '12345678'
           }
         }
  end
  it 'セッションタイムアウト ' do
    travel_to Admin::BaseController::TIMEOUT.from_now.advance(seconds: 1)
    get admin_root_url
    expect(response).to redirect_to admin_login_url
  end
end
feature '管理者による職員管理' do
  let(:admin) { create(:admin) }
  let!(:staff) { create(:staff) }
  before do
    config = Rails.application.config.system_service
    Capybara.app_host = "http://#{config[:admin][:host]}"
    visit admin_login_url
    fill_in 'メールアドレス', with: admin.email
    fill_in 'パスワード', with: '12345678'
    click_button 'ログイン'
  end
  scenario '管理人が職員を追加する' do
    click_link '職員管理'
    expect do
      first('div.links').click_link '新規登録'
      fill_in 'staff_family_name', with: '花田'
      fill_in 'staff_given_name', with: '花子'
      fill_in 'staff_family_name_kana', with: 'ハナダ'
      fill_in 'staff_given_name_kana', with: 'ハナコ'
      fill_in 'メールアドレス', with: 'hanako@example.com'
      fill_in 'パスワード', with: '12345678'
      fill_in 'パスワード確認', with: '12345678'
      fill_in '入社日', with: '2003-01-01'
      fill_in '退社日', with: ''
      uncheck 'アカウント停止'
      click_button '登録'
      expect(page).to have_selector '.notice', text: '登録できました'
      expect(current_path).to eq admin_staff_index_path
    end.to change { Staff.all.count }.by(1)
  end
  scenario '職員の追加に失敗する' do
    click_link '職員管理'
    expect do
      first('div.links').click_link '新規登録'
      click_button '登録'
      expect(page).to have_selector '.alert', text: '登録できませんでした'
      expect(current_path).to eq admin_staff_index_path
    end.to change { Staff.all.count }.by(0)
  end
  scenario '管理人が職員を編集する' do
    click_link '職員管理'
    first('table.listing').click_link '編集'
    fill_in 'staff_given_name', with: '花子'
    click_button '更新する'
    staff.reload
    expect(staff.given_name).to eq '花子'
    expect(page).to have_selector '.notice', text: '編集できました'
    expect(current_path).to eq admin_staff_index_path
  end
  scenario '職員の編集に失敗する' do
    click_link '職員管理'
    first('table.listing').click_link '編集'
    fill_in 'メールアドレス', with: ''
    click_button '更新する'
    expect(page).to have_selector '.alert', text: '編集できませんでした'
    expect(page).to have_selector '.error-message', text: 'メールアドレスが入力されていません'
    expect(current_path).to eq admin_staff_path(staff.id)
  end
end
