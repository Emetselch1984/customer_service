family_names = %w[
  佐藤:サトウ:sato
  鈴木:スズキ:suzuki
  高橋:タカハシ:takahashi
  田中:タナカ:tanaka
]

given_names = %w[
  二郎:ジロウ:jiro
  三郎:サブロウ:saburo
  松子:マツコ:matsuko
  竹子:タケコ:takeko
  梅子:ウメコ:umeko
]
20.times do |n|
  fn = family_names[n % 4].split(':')
  gn = given_names[n % 5].split(':')
  Admin.create!(
    email: Faker::Internet.email,
    password: '12345678',
    password_confirmation: '12345678',
    type: 'Admin'
  )
  Staff.create!(
    email: Faker::Internet.email,
    password: '12345678',
    password_confirmation: '12345678',
    family_name: fn[0],
    given_name: gn[0],
    family_name_kana: fn[1],
    given_name_kana: gn[1],
    start_date: (100 - n).days.ago.to_date,
    end_date: n == 0 ? Date.today : nil,
    suspended: n == 1,
    type: 'Staff'
  )
end
