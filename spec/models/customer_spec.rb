require 'rails_helper'

RSpec.describe Customer, type: :model do
  let(:customer) { build(:customer) }
  context 'customerの保存と取得' do
    it 'スタッフの保存' do
      expect(customer).to be_valid
      customer.save
    end
    it 'スタッフを取得できる' do
      customer.save
      expect(Customer.first).to eq customer
    end
  end
  describe '値の正規化' do
    it 'email前後の空白を除去' do
      customer = create(:customer, email: '  test@example.com')
      expect(customer.email).to eq 'test@example.com'
    end
    it 'email前後の全角スペースを除去' do
      customer = create(:customer, email: "\u{3000}test@example.com\u{3000}")
      expect(customer.email).to eq 'test@example.com'
    end
    it 'emailに含まれる全角英数を半角に変換' do
      customer = create(:customer, email: 'ｔｅｓｔ＠ｅｘａｍｐｌｅ．ｃｏｍ')
      expect(customer.email).to eq 'test@example.com'
    end
    it 'family_name_kanaに含まれるひらがなをカタカナに変換' do
      customer = create(:customer, family_name_kana: 'たかと')
      expect(customer.family_name_kana).to eq 'タカト'
    end
    it 'family_name_kanaに含まれる半角カタカナを全角カタカナに変換' do
      customer = create(:customer, family_name_kana: 'ﾀｶﾄ')
      expect(customer.family_name_kana).to eq 'タカト'
    end
  end
  describe 'バリデーション' do
    it 'emailが空欄' do
      customer = build(:customer, email: nil)
      expect(customer.save).to be_falsey
    end
    it 'emailが256文字以上' do
      customer = build(:customer, email: "#{'a' * 256}@example.com")
      expect(customer.save).to be_falsey
    end
    it 'emailで＠＠などの表記は無効' do
      customer = build(:customer, email: 'test@@example.com')
      expect(customer).not_to be_valid
    end
    it '他の職員と重複したemailは無効' do
      customer1 = create(:customer)
      customer2 = build(:customer, email: customer1.email)
      expect(customer2).not_to be_valid
    end
    pending 'アルファベット記載のfamily_nameは有効'
    it '漢字を含むfamily_name_kanaは無効' do
      customer = build(:customer, family_name_kana: '国雪')
      expect(customer).not_to be_valid
    end
    it '長音府を含むfamily_name_kanaは有効' do
      customer = build(:customer, family_name_kana: 'エリー')
      expect(customer).to be_valid
    end
  end
end
