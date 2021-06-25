FactoryBot.define do
  factory :admin do
    sequence(:email) { |n| "admin#{n}@example.com" }
    password { '12345678' }
    password_confirmation { '12345678' }
    type { 'Admin' }
  end
end
