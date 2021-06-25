require 'rails_helper'

RSpec.describe Staff, type: :model do
  describe '値の正規化' do
    it 'email前後の空白を除去' do
      staff = create(:staff, email: '  test@example.com')
      expect(staff.email).to eq 'test@example.com'
    end
    it 'email前後の全角スペースを除去' do
      staff = create(:staff, email: "\u{3000}test@example.com\u{3000}")
      expect(staff.email).to eq 'test@example.com'
    end
    it 'emailに含まれる全角英数を半角に変換' do
      staff = create(:staff, email: 'ｔｅｓｔ＠ｅｘａｍｐｌｅ．ｃｏｍ')
      expect(staff.email).to eq 'test@example.com'
    end
    it 'family_name_kanaに含まれるひらがなをカタカナに変換' do
      staff = create(:staff, family_name_kana: 'たかと')
      expect(staff.family_name_kana).to eq 'タカト'
    end
    it 'family_name_kanaに含まれる半角カタカナを全角カタカナに変換' do
      staff = create(:staff, family_name_kana: 'ﾀｶﾄ')
      expect(staff.family_name_kana).to eq 'タカト'
    end
  end
  describe 'バリデーション' do
    it 'emailが空欄' do
      staff = build(:staff, email: nil)
      expect(staff.save).to be_falsey
    end
    it 'emailが256文字以上' do
      staff = build(:staff, email: "#{'a' * 256}@example.com")
      expect(staff.save).to be_falsey
    end
    it 'emailで＠＠などの表記は無効' do
      staff = build(:staff, email: 'test@@example.com')
      expect(staff).not_to be_valid
    end
    it '他の職員と重複したemailは無効' do
      staff1 = create(:staff)
      staff2 = build(:staff, email: staff1.email)
      expect(staff2).not_to be_valid
    end
    pending 'アルファベット記載のfamily_nameは有効'
    it '漢字を含むfamily_name_kanaは無効' do
      staff = build(:staff, family_name_kana: '国雪')
      expect(staff).not_to be_valid
    end
    it '長音府を含むfamily_name_kanaは有効' do
      staff = build(:staff, family_name_kana: 'エリー')
      expect(staff).to be_valid
    end
  end
end
