class Staff::SessionsController < Staff::BaseController
  skip_before_action :require_login, only: %i[new create]
  skip_before_action :check_timeout, only: %i[new create]
  skip_before_action :check_account, only: %i[new create]
  def new
    @form = Staff::LoginForm.new
    render :new
  end

  def create
    @user = login(params[:staff_login_form][:email], params[:staff_login_form][:password])
    if @user.suspended?
      @user.event.create!(type: 'rejected')
      flash.alert = 'アカウントが停止されています'
      render :new
    elsif Staff::Authenticator.new(@user).authenticate
      @user.event.create!(type: 'logged_in')
      session[:last_access_time] = Time.current
      redirect_back_or_to staff_root_path, notice: 'ログインしました'
    else
      flash.now.alert = 'メールまたはアドレスが正しくありません。'
      render :new
    end
  end

  def destroy
    current_user.event.create!(type: 'logged_out')
    logout
    flash.notice = 'ログアウトしました'
    redirect_to staff_root_path
  end
end
