require 'rails_helper'

describe 'ログイン前' do
  let(:args) do
    {
      host: Rails.application.config.system_service[:staff][:host],
      controller: 'staff/accounts'
    }
  end
  describe '#index' do
    it 'ログインフォームにリダイレクト' do
      get url_for(args.merge(action: :show))
      expect(response).to redirect_to(staff_login_url)
    end
  end
end
describe '職員による自分のアカウント管理' do
  before do
    post staff_login_url,
         params: {
           staff_login_form: {
             email: staff.email,
             password: '12345678'
           }
         }
  end
  describe '情報表示' do
    let(:staff) { create(:staff) }
    it '成功' do
      get staff_account_url
      expect(response.status).to eq(200)
    end
    it '停止フラグがセットされたら強制的にログアウト' do
      staff.update_column(:suspended, true)
      get staff_account_url
      expect(response).to redirect_to(staff_root_path)
    end
    it 'セッションタイムアウト' do
      travel_to Staff::BaseController::TIMEOUT.from_now.advance(seconds: 1)
      get staff_account_url
      expect(response).to redirect_to staff_login_url
    end
  end
  describe '更新' do
    let(:params) { attributes_for(:staff) }
    let(:staff) { create(:staff) }
    it 'emailを更新する' do
      params.merge!(email: 'taro@example.com')
      patch staff_account_url,
            params: { id: staff.id,
                      staff: params }
      staff.reload
      expect(staff.email).to eq 'taro@example.com'
    end
    it 'end_dateの書き換えは不可' do
      params.merge!(end_date: Date.today)
      expect do
        patch staff_account_url,
              params: {
                id: staff.id,
                staff: params,
                commit: '更新'
              }
      end.not_to change { staff.end_date }
    end
  end
end
