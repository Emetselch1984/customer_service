class Customer::SessionsController < Customer::BaseController
  skip_before_action :require_login, only: %i[new create]
  skip_before_action :check_timeout, only: %i[new create]
  skip_before_action :check_account, only: %i[new create]

  def new
    @form = Customer::LoginForm.new
    render :new
  end

  def create
    @user = login(params[:customer_login_form][:email], params[:customer_login_form][:password],
                  params[:customer_login_form][:remember])
    if @user.suspended?
      flash.alert = 'アカウントが停止されています'
      render :new
    end
    if @user
      session[:last_access_time] = Time.current
      redirect_back_or_to customer_root_path, notice: 'ログインしました'
    else
      flash.now.alert = 'メールまたはアドレスが正しくありません。'
      render :new
    end
  end

  def destroy
    logout
    redirect_to customer_login_path, notice: 'ログアウトしました'
  end

  private
  def login_form_params
    params.require(:customer_login_form).permit(:email, :password, :remember)
  end
end
