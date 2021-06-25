FactoryBot.define do
  factory :staff do
    sequence(:email) { |n| "member#{n}@example.com" }
    password              { '12345678' }
    password_confirmation { '12345678' }
    type { 'Staff' }
    family_name { '山田' }
    given_name { '太郎' }
    family_name_kana { 'ヤマダ' }
    given_name_kana { 'タロウ' }
    start_date { Date.yesterday }
    end_date { nil }
    suspended { false }
  end
end
