class Admin::StaffEventsController < Admin::BaseController
  def index
    @staff = Staff.find(params[:staff_id])
    @events = StaffEvent.order(occurred_at: :desc).includes(:user).page(params[:page])
  end
end
