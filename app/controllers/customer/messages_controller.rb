class Customer::MessagesController < Customer::BaseController
  def new
    @message = CustomerMessage.new
  end

  def confirm
    @message = CustomerMessage.new(customer_message_params)
    @message.user = current_user
    if @message.valid?
      render :confirm
    else
      flash.now.alert = '⼊⼒に誤りがあります。'
      render :new
    end
  end

  def create
    @message = CustomerMessage.new(customer_message_params)
    if params[:commit]
      @message.user = current_user
      if @message.save
        redirect_to customer_root_path, notice: '問い合わせを送信しました。'
      else
        flash.now.alert = '⼊⼒に誤りがあります。'
        render :new
      end
    else
      render :new
    end
  end

  private

  def customer_message_params
    params.require(:customer_message).permit(:subject, :body)
  end
end
