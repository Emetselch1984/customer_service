class Phone < ApplicationRecord
  include StringNormalizer

  belongs_to :user, optional: true
  belongs_to :address, optional: true

  before_validation do
    self.number = normalize_as_phone_number(number)
    self.number_for_index = number.gsub(/\D/, '') if number
  end

  before_create do
    self.user = address.user if address
  end

  validates :number,
            format: { with: /\A\+?\d+(-\d+)*\z/, allow_blank: true },
            length: {maximum: 30}

end
