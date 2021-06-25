describe '管理者による職員管理', 'ログイン前' do
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
Rails.application.routes.draw do
  config = Rails.application.config.system_service[:admin][:host]
  constraints host: config[:admin][:host] do
    namespace :admin do
      post 'login', to: 'sessions#create'
      resources :staff
    end
  end
end
class Admin::StaffController < Admin::Basecontroller
  def index; end
end

class Admin::BaseController < ApplicationController
  before_action :require_login
  def not_authenticated
    redirect_to admin_login_path
  end
end
