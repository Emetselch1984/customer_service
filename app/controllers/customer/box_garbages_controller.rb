class Customer::BoxGarbagesController < Customer::BaseController
  def index
    @messages = current_user.messages.discarded.sorted.page(params[:page])
  end

  def destroy
    message = current_user.messages.discarded.sorted.page(params[:page])
    message.destroy!
    flash.notice = 'メールを削除しました'
    redirect_to customer_box_garbage_path
  end

  def all_destroy
    messages = messages = current_user.messages.discarded
    messages.map(&:destroy!)
    flash.notice = 'メール全てを削除しました'
    redirect_to customer_box_garbages_path
  end
end
