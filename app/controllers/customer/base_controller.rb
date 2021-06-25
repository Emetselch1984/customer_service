class Customer::BaseController < ApplicationController
  before_action :require_login
  before_action :check_timeout
  before_action :check_account

  private

  def not_authenticated
    flash.alert = 'ログインして下さい'
    redirect_to customer_login_path
  end

  def check_account
    if current_user && !current_user.active?
      logout
      flash.alert = 'アカウントが無効になりました'
      redirect_to customer_root_path
    end
  end
  TIMEOUT = 60.minutes
  def check_timeout
    if logged_in?
      if session[:last_access_time] >= TIMEOUT.ago
        session[:last_access_time] = Time.current
      else
        logout
        flash.alert = 'セッションがタイムアウトしました'
        redirect_to customer_login_path
      end
    end
  end
end
