staff = Staff.order(:id)

20.times do |n|
  t = (18 - n).weeks.ago
  Program.create!(
    title: "プログラムNo.#{n + 1}",
    description: '会員向け特別プログラムです。' * 10,
    application_start_date: t,
    application_end_date: t.advance(days: 7),
    registrant: staff.sample
  )
end
