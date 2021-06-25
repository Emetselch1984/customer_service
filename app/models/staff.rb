class Staff < User
  include EmailHolder
  include PersonalNameHolder
  before_validation do
    self.email = normalize_as_email(email)
  end
  validates :email, presence: true, "valid_email_2/email": true,
                    uniqueness: { case_sensitive: false }, length: { maximum: 256 }
  validates :family_name, length: { maximum: 256 }
  validates :family_name, presence: true
  validates :family_name_kana, length: { maximum: 256 }
  validates :family_name_kana, presence: true
  validates :given_name, length: { maximum: 256 }
  validates :given_name, presence: true
  validates :given_name_kana, length: { maximum: 256 }
  validates :given_name_kana, presence: true
  validates :start_date, date: {
    after_or_equal_to: Date.new(2000, 1, 1),
    before: ->(_obj) { 1.year.from_now.to_date },
    allow_blank: true
  }
  validates :end_date, date: {
    after: :start_date,
    before: ->(_obj) { 1.year.from_now.to_date },
    allow_blank: true
  }
  def active?
    !suspended? && start_date <= Date.today && (end_date.nil? || end_date > Date.today)
  end
end
