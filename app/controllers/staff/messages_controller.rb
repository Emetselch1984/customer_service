class Staff::MessagesController < Staff::BaseController
  def index
    @messages = Message.not_deleted.sorted.page(params[:page])
  end

  def show
    @message = Message.find(params[:id])
    @message.update_column(:status, 'read')
  end

  def inbound
    @messages = CustomerMessage.not_deleted.sorted.page(params[:page])
    render :index
  end

  def outbound
    @messages = StaffMessage.not_deleted.sorted.page(params[:page])
    render :index
  end

  def all_read
    messages = Message.not_deleted
    messages.each do |message|
      message.update_column(:status, 'read')
    end
    redirect_to staff_messages_path
  end

  def inbound_all_read
    messages = CustomerMessage.not_deleted
    messages.each do |message|
      message.update_column(:status, 'read')
    end
  end

  def outbound_all_read
    messages = current_user.outbound_messages.not_deleted
    messages.each do |message|
      message.update_column(:status, 'read')
    end
  end

  def destroy
    message = StaffMessage.find(params[:id])
    message.update_column(:deleted, true)
    flash.notice = 'ゴミ箱に移動しました'
    redirect_back(fallback_location: :staff_root)
  end
end
