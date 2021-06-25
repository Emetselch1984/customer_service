require 'rails_helper'
describe '管理者による職員管理', 'ログイン前' do
  # include_examples "a protected admin controller", "admin/staff"
  let(:args) do
    {
      host: Rails.application.config.system_service[:admin][:host],
      controller: 'admin/staff'
    }
  end
  describe '#index' do
    it 'ログインフォームにリダイレクト' do
      get url_for(args.merge(action: :index))
      expect(response).to redirect_to(admin_login_url)
    end
  end
end
describe '管理者による職員管理' do
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
  describe '一覧' do
    it '成功' do
      get admin_staff_index_url
      expect(response.status).to eq(200)
    end
    it 'セッションタイムアウト' do
      travel_to Admin::BaseController::TIMEOUT.from_now.advance(seconds: 1)
      get admin_staff_index_url
      expect(response).to redirect_to admin_login_url
    end
  end
end
