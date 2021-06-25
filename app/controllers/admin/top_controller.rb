class Admin::TopController < Admin::BaseController
  def index
    if logged_in?
      render :dashboard
    else
      render :index
    end
  end
end
