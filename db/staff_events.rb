staff = Staff.all

256.times do |n|
  m = staff.sample
  e = m.event.build
  e.type = if m.active?
             if n.even?
               'logged_in'
             else
               'logged_out'
             end
           else
             'rejected'
           end
  e.occurred_at = (256 - n).hours.ago
  e.save!
end
