class Program < ApplicationRecord
  has_many :entries, dependent: :destroy
  has_many :applicants, through: :entries, source: :user
  belongs_to :registrant, class_name: 'Staff'
end
