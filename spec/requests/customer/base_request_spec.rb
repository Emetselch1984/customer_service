require 'rails_helper'

RSpec.describe 'Customer::Bases', type: :request do
  describe 'ログイン前' do
    let(:args) do
      {
        host: Rails.application.config.system_service[:customer][:host],
        controller: 'customer/top'
      }
    end
    describe '#index' do
      it 'ログインフォームにリダイレクト' do
        get url_for(args.merge(action: :index))
        expect(response).to redirect_to(customer_login_url)
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
  end
end
