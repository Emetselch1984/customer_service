class Staff::AjaxController < ApplicationController
  before_action :require_login
  before_action :check_timeout

  def message_count
    render plain: CustomerMessage.unprocessed.count
  end

  def not_authenticated
    render plain: 'Forbidden', status: 403
  end

  TIMEOUT = 60.minutes
  def check_timeout
    unless session[:last_access_time] &&
           session[:last_access_time] >= Staff::BaseController::TIMEOUT.ago
      logout
      render plain: 'Forbidden', status: 403
    end
  end
end
