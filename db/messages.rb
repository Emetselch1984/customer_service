customers = Customer.all
staff = Staff.where(suspended: false).all
s = 2.years.ago
23.times do |n|
  m = CustomerMessage.create!(
    user: customers.sample,
    subject: 'これは問い合わせです。' * 4,
    body: "これは問い合わせです。\n" * 8,
    created_at: s.advance(months: n)
  )
  r = StaffMessage.create!(
    user: m.user,
    staff: staff.sample,
    root: m,
    parent: m,
    subject: 'これは返信です。' * 4,
    body: "これは返信です。\n" * 8,
    created_at: s.advance(months: n, hours: 1)
  )
  next unless n % 6 == 0

  m2 = CustomerMessage.create!(
    user: r.user,
    root: m,
    parent: r,
    subject: 'これは返信への回答です。',
    body: 'これは返信への回答です。',
    created_at: s.advance(months: n, hours: 2)
  )
  StaffMessage.create!(
    user: m2.user,
    staff: staff.sample,
    root: m,
    parent: m2,
    subject: 'これは回答への返信です。',
    body: 'これは回答への返信です。',
    created_at: s.advance(months: n, hours: 3)
  )
end

s = 24.hours.ago
8.times do |n|
  CustomerMessage.create!(
    user: customers.sample,
    subject: 'これは問い合わせです。' * 4,
    body: "これは問い合わせです。\n" * 8,
    created_at: s.advance(hours: n * 3)
  )
end
