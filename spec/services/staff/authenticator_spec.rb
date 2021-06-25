require 'rails_helper'

describe Staff::Authenticator do
  describe '#authenticate' do
    it '停止フラグが立っていたらfalseを返す' do
      m = build(:staff, suspended: true)
      expect(Staff::Authenticator.new(m).authenticate).to be_falsey
    end

    it '開始前ならfalseを返す' do
      m = build(:staff, start_date: Date.tomorrow)
      expect(Staff::Authenticator.new(m).authenticate).to be_falsey
    end

    it '終了後ならfalseを返す' do
      m = build(:staff, end_date: Date.today)
      expect(Staff::Authenticator.new(m).authenticate).to be_falsey
    end
  end
end
