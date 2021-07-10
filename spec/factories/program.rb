FactoryBot.define do
  factory :program do
    title {"test"}
    description {"test"}
    application_start_time {Time.new(2021,7,5,12,15)}
    application_start_time {Time.new(2021,7,12,12,15)}

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
