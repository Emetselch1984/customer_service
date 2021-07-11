require 'rails_helper'

feature 'プログラム一覧画面' do
  include FeaturesSpecHelper
  let(:staff) { create(:staff) }
  let(:customer) { create(:customer) }
  start_time =Time.new(2021, 7, 5, 12, 15)
  end_time =Time.new(2021, 7, 15, 15, 55)

  let(:args) do
    {
        title: 'testタイトル',
        description: 'test本文',
        application_start_date: start_time.to_date,
        application_start_hour:start_time.hour,
        application_start_minute: start_time.min,
        application_end_date: end_time.to_date,
        application_end_hour: end_time.hour,
        application_end_minute: end_time.min,
        min_number_of_participants: '3',
        max_number_of_participants: '6'
    }
  end

  before do
    switch_namespace(:customer)
    login_as_customer(customer)
  end

  scenario '一覧画面の表示' do
    staff.programs.create!(args)
    click_link 'プログラム一覧'
    expect(current_path).to eq customer_programs_path
    expect(page).to have_content 'プログラム⼀覧'
    expect(page).to have_content 'testタイトル'
    expect(page).to have_content '2021-07-05 12:15'
  end
  scenario '詳細画面の表示' do
    staff.programs.create!(args)
    click_link 'プログラム一覧'
    first('table.listing').click_link '詳細'
    expect(current_path).to eq customer_program_path(staff.programs.first)
    expect(page).to have_content 'プログラム詳細情報'
    expect(page).to have_content 'testタイトル'
    expect(page).to have_content '2021-07-05 12:15'
    expect(page).to have_button '申し込む'

  end

end
