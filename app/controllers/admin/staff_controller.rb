class Admin::StaffController < Admin::BaseController
  skip_before_action :require_login, only: %i[new create]
  def index
    @staff = Staff.order(:family_name_kana, :given_name_kana)
  end

  def new
    @staff = Staff.new
  end

  def create
    @staff = Staff.new(staff_params)
    if @staff.save
      redirect_to admin_staff_index_url, notice: '登録できました'
    else
      flash.now.alert = '登録できませんでした'
      render :new
    end
  end

  def edit
    @staff = Staff.find(params[:id])
  end

  def update
    @staff = Staff.find(params[:id])
    @staff.assign_attributes(staff_params)

    if @staff.save
      redirect_to admin_staff_index_url, notice: '編集できました'
    else
      flash.now.alert = '編集できませんでした'
      render :edit
    end
  end

  def destroy
    @staff = Staff.find(params[:id])
    if @staff.delete
      @staff.destroy!
      redirect_to admin_staff_index_path, notice: '削除しました'
    else
      flash.alert = '削除できませんでした'
      render :index
    end
  end

  private

  def staff_params
    params.require(:staff).permit(
      :email, :password, :password_confirmation, :family_name, :given_name,
      :family_name_kana, :given_name_kana,
      :start_date, :end_date, :suspended
    )
  end
end
