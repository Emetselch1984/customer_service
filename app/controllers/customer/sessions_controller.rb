class Customer::SessionsController < Customer::BaseController
  def new
    @form = Customer::LoginForm.new
    render :new
  end

  def create
    @user = login(params[:customer_login_form][:email], params[:customer_login_form][:password])
    if @user
      redirect_back_or_to customer_root_path, notice: 'ログインしました'
    else
      flash.now.alert = 'メールまたはアドレスが正しくありません。'
      render :new
    end
  end

  def destroy
    logout
    redirect_to customer_root_path
  end
end
