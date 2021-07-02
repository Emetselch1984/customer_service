class Staff::MessagesController < Staff::BaseController
  def index
    @messages = Message.not_deleted.sorted.page(params[:page])
  end

  def inbound
    @messages = CustomerMessage.not_deleted.sorted.page(params[:page])
    render :index
  end

  def outbound
    @messages = StaffMessage.not_deleted.sorted.page(params[:page])
    render :index
  end

  def deleted
    @messages = Message.deleted.sorted.page(params[:page])
    render :index
  end

  def destroy
    message = CustomerMessage.find(params[:id])
    message.update_column(:deleted, true)
    flash.notice = '問い合わせを削除しました'
    redirect_back(fallback_location: :staff_root)
  end
end
