class Admin::BaseController < ApplicationController
  before_action :require_login
  before_action :check_timeout

  private

  def not_authenticated
    flash.alert = 'ログインして下さい'
    redirect_to admin_login_path
  end
  TIMEOUT = 60.minutes
  def check_timeout
    if logged_in?
      if session[:last_access_time] >= TIMEOUT.ago
        session[:last_access_time] = Time.current
      else
        logout
        flash.alert = 'セッションがタイムアウトしました'
        redirect_to admin_login_path
      end
    end
  end
end
