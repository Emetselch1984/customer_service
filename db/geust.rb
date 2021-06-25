Admin.create!(
  email: 'admin@example.com',
  password: '12345678',
  password_confirmation: '12345678',
  type: 'Admin'
)

Staff.create!(
  email: 'staff@example.com',
  password: '12345678',
  password_confirmation: '12345678',
  type: 'Staff',
  family_name: '太郎',
  given_name: '生野',
  family_name_kana: 'タロウ',
  given_name_kana: 'イクノ',
  start_date: 3.days.ago.to_date,
  end_date: nil,
  suspended: 0
)
Customer.create!(
  email: 'customer@example.com',
  family_name: 'ゲスト',
  given_name: '太郎',
  family_name_kana: 'ゲスト',
  given_name_kana: 'タロウ',
  password: '12345678',
  password_confirmation: '12345678',
  type: 'Customer',
  birthday: 60.years.ago.advance(seconds: rand(40.years)).to_date,
  gender: 'male'
)
