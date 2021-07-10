FactoryBot.define do
  factory :program do
    title { 'test' }
    description { 'test' }
    application_start_time { Time.new(2021, 7, 5, 12, 15) }
    application_end_time { Time.new(2021, 7, 12, 12, 15) }

    min_number_of_participants { '3' }
    max_number_of_participants { '6' }
  end
end
