class Admin::SessionsController < Admin::BaseController
  skip_before_action :require_login, only: %i[new create]
  def new
    @form = Admin::LoginForm.new
  end

  def create
    @user = login(params[:admin_login_form][:email], params[:admin_login_form][:password])
    if @user
      session[:last_access_time] = Time.current
      redirect_back_or_to admin_root_path, notice: 'ログインしました'
    else
      flash.now.alert = 'メールまたはアドレスが正しくありません。'
      render :new
    end
  end

  def destroy
    logout
    flash.notice = 'ログアウトしました'
    redirect_to admin_login_path
  end
end
