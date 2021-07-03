FactoryBot.define do
  factory :message do
    subject {'これは問い合わせです。' * 4}
    body {"これは問い合わせです。\n" * 8}
  end
end