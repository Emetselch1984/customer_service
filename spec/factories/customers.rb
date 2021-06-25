FactoryBot.define do
  factory :customer do
    sequence(:email) { |n| "member#{n}@example.jp" }
    family_name { '山田' }
    given_name { '太郎' }
    family_name_kana { 'ヤマダ' }
    given_name_kana { 'タロウ' }
    password { '12345678' }
    password_confirmation { '12345678' }
    birthday { Date.new(1970, 1, 1) }
    gender { 'male' }
    type { 'Customer' }
    # 関連されたオブジェクトが保存しないようにす
    association :home_address, strategy: :build
    association :work_address, strategy: :build
  end
end
