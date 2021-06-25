class Staff::AccountsController < Staff::BaseController
  def show
    @staff = current_user
  end

  def edit
    @staff = current_user
  end

  def update
    @staff = current_user
    @staff.assign_attributes(staff_params)
    if @staff.save
      redirect_to staff_account_url, notice: '編集できました'
    else
      flash.now.alert = '編集できませんでした'
      render :edit
    end
  end

  def confirm
    @staff = current_user
    @staff.assign_attributes(staff_params)
  end
end

private

def staff_params
  params.require(:staff).permit(
    :email, :family_name, :given_name,
    :family_name_kana, :given_name_kana
  )
end
