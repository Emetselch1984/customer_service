class Staff::EntriesController < Staff::BaseController
  def update_all
    entries_form = Staff::EntriesForm.new(Program.find(params[:program_id]))
    entries_form.update_all(params)
    redirect_to staff_programs_path, notice: 'プログラム申し込みのフラグを更新しました'
  end
end
