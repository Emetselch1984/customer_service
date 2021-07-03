class Staff::RepliesController < Staff::BaseController
  before_action :prepare_messages
  def new
    @reply = StaffMessage.new
  end
  def confirm
    @reply = StaffMessage.new(staff_message_params)
  end

  def create
    @reply = StaffMessage.new(staff_message_params)
    if params[:commit]
      @reply.user = current_user
      @reply.parent = @message
      if @reply.save
        redirect_to outbound_staff_messages_path,notice: "問い合わせに返信しました"
      else
        flash.now.alert = "入力に誤りがあります"
        render :new
      end
    end
  end


  private
  def prepare_messages
    @message = CustomerMessage.find(params[:message_id])
  end
  def staff_message_params
    params.require(:staff_message).permit(:subject, :body)
  end
end
