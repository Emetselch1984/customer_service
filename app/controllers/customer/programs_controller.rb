class Customer::ProgramsController < Customer::BaseController
  def index
    @programs = Program.published.page(params[:page])
  end

  def show
    @program = Program.published.find(params[:id])
  end
end
