class Customer::RepliesController < Customer::BaseController
  before_action :prepare_message
  def new
    @reply = CustomerMessage.new
  end

  def confirm
    @reply = CustomerMessage.new(customer_message_params)
    @reply.parent = @message
    if @reply.valid?
      render :confirm
    else
      flash.now.alert = '入力に誤りがあります'
      render :new
    end
  end

  def create
    @reply = CustomerMessage.new(customer_message_params)
    if params[:commit]
      @reply.parent = @message
      if @reply.save
        redirect_to customer_messages_path, notice: 'メッセージに回答しました'
      else
        flash.now.alert = '入力に誤りがあります'
        render :new
      end
    else
      render :new
    end
  end

  private

  def prepare_message
    @message = StaffMessage.find(params[:message_id])
  end

  def customer_message_params
    params.require(:customer_message).permit(:subject, :body)
  end
end
