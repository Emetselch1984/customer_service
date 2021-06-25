class Customer::SessionsController < Customer::BaseController
  def new; end

  def create
    @user = login(params[:email], params[:password])
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
