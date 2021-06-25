Rails.application.configure do
  config.system_service = {
    staff: { host: 'staff.com', path: 'staff' },
    admin: { host: 'admin.com', path: 'admin' },
    customer: { host: 'customer.com', path: 'customer' }
  }
end
