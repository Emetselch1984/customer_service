class Staff::ProgramsController < ApplicationController
  def index
    @programs = Program.listing.page(params[:page])
  end

  def show
    @program = Program.listing.find(params[:id])
  end
end

Program.order(application_start_time: :desc).includes(:registrant)\
       .find(17).applicants.count
Program.listing.find(17).entries.count
Program.left_joins(:entries)\
       .select('programs.*, COUNT(entries.id) AS number_of_applicants')\
       .group('programs.id')
