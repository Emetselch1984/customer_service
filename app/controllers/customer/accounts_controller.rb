class Customer::AccountsController < Customer::BaseController
  def show
    @customer = current_user
  end

  def edit
    @customer_form = Customer::AccountForm.new(current_user)
  end

  def confirm
    @customer_form = Customer::AccountForm.new(current_user)
    @customer_form.assign_attributes(params[:form])
    if @customer_form.valid?
      render :confirm
    else
      flash.now.alert = '入力に誤りがあります'
      render :edit
    end
  end

  def update
    @customer_form = Customer::AccountForm.new(current_user)
    @customer_form.assign_attributes(params[:form])
    if params[:commit]
      if @customer_form.save
        redirect_to customer_account_path, notice: 'アカウント情報を更新しました'
      else
        flash.now.alert = '入力に誤りがあります'
        render :edit
      end
    else
      render :edit
    end
  end
end
