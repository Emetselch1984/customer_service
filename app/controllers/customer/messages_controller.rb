class Customer::MessagesController < Customer::BaseController
  def new
    @message = CustomerMessage.new
  end

  def index
    @messages = current_user.messages.where(discarded: false).sorted.page(params[:page])
  end

  def show
    @message = current_user.messages.find(params[:id])
    @message.update_column(:status, 'read')
  end

  def inbound
    @messages = current_user.inbound_messages.where(discarded: false).sorted.page(params[:page])
    render :index
  end

  def outbound
    @messages = current_user.outbound_messages.where(discarded: false).sorted.page(params[:page])
    render :index
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

  def destroy
    message = current_user.inbound_messages.find(params[:id])
    message.update_column(:discarded, true)
    flash.notice = 'メッセージを削除しました'
    redirect_back(fallback_location: :customer_messages)
  end

  def all_read
    messages = current_user.messages.where(discarded: false)
    messages.each do |message|
      message.update_column(:status, 'read')
    end
  end

  def inbound_all_read
    messages = current_user.inbound_messages.where(discarded: false)
    messages.each do |message|
      message.update_column(:status, 'read')
    end
  end

  def outbound_all_read
    messages = current_user.outbound_messages.where(discarded: false)
    messages.each do |message|
      message.update_column(:status, 'read')
    end
  end

  private

  def customer_message_params
    params.require(:customer_message).permit(:subject, :body)
  end
end
