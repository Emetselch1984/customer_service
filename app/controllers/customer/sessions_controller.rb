class Customer::SessionsController < Customer::BaseController
  def new
    @form = Staff::LoginForm.new
  end

  def create
    @user = login(params[:customer_login_form][:email], params[:customer_login_form][:password])
    if @user
      redirect_back_or_to customer_root_path
    else
      render :new
    end
  end

  def destroy
    logout
    redirect_to customer_root_path
  end
end
