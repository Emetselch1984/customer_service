require 'rails_helper'

RSpec.describe Admin, type: :model do
  describe '値の正規化' do
    it 'email前後の空白を除去' do
      admin = create(:admin, email: '  test@example.com')
      expect(admin.email).to eq 'test@example.com'
    end
    it 'email前後の全角スペースを除去' do
      admin = create(:admin, email: "\u{3000}test@example.com\u{3000}")
      expect(admin.email).to eq 'test@example.com'
    end
    it 'emailに含まれる全角英数を半角に変換' do
      admin = create(:admin, email: 'ｔｅｓｔ＠ｅｘａｍｐｌｅ．ｃｏｍ')
      expect(admin.email).to eq 'test@example.com'
    end
  end
  describe 'バリデーション' do
    it 'emailが空欄' do
      admin = build(:admin, email: nil)
      expect(admin.save).to be_falsey
    end
    it 'emailが256文字以上' do
      admin = build(:admin, email: 'a' * 256 + '@example.com')
      expect(admin.save).to be_falsey
    end
    it 'emailで＠＠などの表記は無効' do
      admin = build(:admin, email: 'test@@example.com')
      expect(admin).not_to be_valid
    end
    it '他の職員と重複したemailは無効' do
      admin1 = create(:admin)
      admin2 = build(:admin, email: admin1.email)
      expect(admin2).not_to be_valid
    end
  end
end
