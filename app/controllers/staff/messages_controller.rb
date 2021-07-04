class Staff::MessagesController < Staff::BaseController
  def index
    @messages = Message.not_deleted.sorted.page(params[:page])
  end

  def show
    @message = Message.find(params[:id])
  end

  def inbound
    @messages = CustomerMessage.not_deleted.sorted.page(params[:page])
    render :index
  end

  def outbound
    @messages = StaffMessage.not_deleted.sorted.page(params[:page])
    render :index
  end

  def destroy
    message = StaffMessage.find(params[:id])
    message.update_column(:deleted, true)
    flash.notice = 'ゴミ箱に移動しました'
    redirect_back(fallback_location: :staff_root)
  end
end
