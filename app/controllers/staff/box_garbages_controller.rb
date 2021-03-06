class Staff::BoxGarbagesController < Staff::BaseController
  def index
    @messages = Message.deleted.sorted.page(params[:page])
  end

  def destroy
    message = Message.find(params[:id])
    message.destroy!
    flash.notice = 'メールを削除しました'
    redirect_to staff_box_garbages_path
  end

  def all_destroy
    messages = Message.deleted
    messages.map(&:destroy!)
    flash.notice = 'メール全てを削除しました'
    redirect_to staff_box_garbages_path
  end
end
