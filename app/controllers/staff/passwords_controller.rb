class Staff::PasswordsController < ApplicationController
  def show
    redirect_to edit_staff_password_url
  end

  def edit
    @change_password_form =
      Staff::ChangePasswordForm.new(object: current_user)
  end

  def update
    @change_password_form = Staff::ChangePasswordForm.new(staff_params)
    @change_password_form.object = current_user
    if @change_password_form.save
      flash.notice = 'パスワードを変更しました'
      redirect_to staff_account_url
    else
      flash.now.alert = '入力に誤りがあります'
      render :edit

    end
  end

  private

  def staff_params
    params.require(:staff_change_password_form).permit(:current_password,
                                                       :new_password,
                                                       :new_password_confirmation)
  end
end
