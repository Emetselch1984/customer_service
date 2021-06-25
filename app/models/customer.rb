class Customer < User
  include EmailHolder
  include PersonalNameHolder
  before_validation do
    self.email = normalize_as_email(email)
  end
  validates :email, presence: true, "valid_email_2/email": true,
                    uniqueness: { case_sensitive: false }, length: { maximum: 256 }
  validates :gender, inclusion: { in: %w[male female], allow_blank: true }
  validates :birthday, date: {
    after: Date.new(1900, 1, 1),
    before: ->(_obj) { Date.today },
    allow_blank: true
  }
  before_save do
    if birthday
      self.birth_year = birthday.year
      self.birth_month = birthday.month
      self.birth_mday = birthday.mday
    end
  end
end
