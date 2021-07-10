require 'rails_helper'

feature '検索フィールド' do
  include FeaturesSpecHelper
  let(:staff) { create(:staff) }
  let!(:customer) { create(:customer) }
  let!(:customer2) do
    create(:customer,
           family_name: '花田',
           given_name: '花子',
           family_name_kana: 'ハナダ',
           given_name_kana: 'ハナコ',
           birthday: Date.new(1980, 2, 23),
           gender: 'female')
  end
  before do
    switch_namespace(:staff)
    login_as_staff(staff)
  end
  scenario '都道府県による顧客の検索' do
    click_link '顧客管理'
    fill_in '都道府県', with: '東京都'
    click_button '検索'
    expect(page).to have_content '山田'
  end
  scenario 'フリガナによる顧客の検索' do
    click_link '顧客管理'
    fill_in 'フリガナ（姓）:', with: 'ハナダ'
    click_button '検索'
    expect(page).to have_content '花田'
  end
  scenario '誕生年による顧客の検索' do
    click_link '顧客管理'
    select '1970', from: '誕⽣年:'
    click_button '検索'
    expect(page).to have_content '山田'
  end
  scenario '誕生月による顧客の検索' do
    click_link '顧客管理'
    select '1', from: '誕⽣⽉:'
    click_button '検索'
    expect(page).to have_content '山田'
  end
  scenario '性別による顧客の検索' do
    click_link '顧客管理'
    select '男性', from: '性別:'
    click_button '検索'
    expect(page).to have_content '山田'
  end
  scenario '都道府県による顧客の検索' do
    click_link '顧客管理'
    select '東京都', from: '都道府県:'
    click_button '検索'
    expect(page).to have_content '山田'
  end
  scenario '市町村区による顧客の検索' do
    click_link '顧客管理'
    fill_in '市区町村:', with: '千代田区'
    click_button '検索'
    expect(page).to have_content '山田'
  end
  scenario '郵便番号による顧客の検索' do
    click_link '顧客管理'
    fill_in '郵便番号:', with: '1000000'
    click_button '検索'
    expect(page).to have_content '山田'
  end
  scenario '電話番号による顧客の検索' do
    customer.personal_phones.create!(number: '080-1111-1111')
    click_link '顧客管理'
    fill_in '電話番号:', with: '080-1111-1111'
    click_button '検索'
    expect(page).to have_content '山田'
  end
end
