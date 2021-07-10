require 'rails_helper'

RSpec.describe Program, type: :model do
  let(:staff) {create(:staff)}
  let(:args) {
    {
      title: "test" ,
      description: "test" ,
      application_start_time: Time.new(2021,7,5,12,15),
      application_end_time: Time.new(2021,7,12,12,15),
      min_number_of_participants: '3',
      max_number_of_participants: '6'
    }
  }
  describe 'バリデーション' do
    it 'programを保存' do
      program = staff.programs.build(args)
      expect(program).to be_valid
      program.save
      expect(Program.all.size).to eq 1
    end
    it 'titleが空欄' do
      program = staff.programs.build(args.merge({
                                                  title: nil
                                                }))
      expect(program).not_to be_valid
    end
    it 'titleの長さが33文字' do
      program = staff.programs.build(args.merge({
                                                  title: "a" * 33
                                                }))
      expect(program).not_to be_valid
    end
    it 'descriptionが空欄' do
      program = staff.programs.build(args.merge({
                                                  description: nil
                                                }))
      expect(program).not_to be_valid
    end

    it 'descriptionの長さが801文字' do
      program = staff.programs.build(args.merge({
                                                  description: "a" * 801
                                                }))
      expect(program).not_to be_valid
    end
    it '申し込み日が2000年1月1より前' do
      program = staff.programs.build(args.merge({
                                                  application_start_date: Time.new(1999,12,31)
                                                }))
      expect(program).not_to be_valid
    end
    it '申し込み日が現在時刻より1年と1日後' do
      program = staff.programs.build(args.merge({
                                                  application_start_date: 366.days.from_now
                                                }))
      expect(program).not_to be_valid
    end
    it '申し込み終了日が申し込み開始日より前' do
      program = staff.programs.build(args.merge({
                                                  application_start_date: Time.new(2021,7,5,12,15),
                                                  application_end_date: Time.new(2021,7,4,12,15)
                                                }))
      expect(program).not_to be_valid
    end
    it '申し込み終了日が申し込み開始日より91日後' do
      time = Time.new(2021,7,5,12,15)
      program = staff.programs.build(args.merge({
                                                  application_start_date: time,
                                                  application_end_date: time.advance(days: 91)
                                                }))
      expect(program).not_to be_valid
    end
    it '最小人数が負の値' do
      program = staff.programs.build(args.merge({
                                                  min_number_of_participants: -1,
                                                  max_number_of_participants: 7
                                                }))
      expect(program).not_to be_valid
    end
    it '最大人数が1001' do
      program = staff.programs.build(args.merge({
                                                  min_number_of_participants: 1,
                                                  max_number_of_participants: 1001
                                                }))
      expect(program).not_to be_valid
    end
    it '最小最大人数が整数ではない' do
      program = staff.programs.build(args.merge({
                                                  min_number_of_participants: 6.7,
                                                  max_number_of_participants: 7.5
                                                }))
      expect(program).not_to be_valid
    end
    it '最小人数が最大人数より多い' do
      program = staff.programs.build(args.merge({
                                                  min_number_of_participants: 6,
                                                  max_number_of_participants: 5
                                                }))
      expect(program).not_to be_valid
    end
    
  end
end
