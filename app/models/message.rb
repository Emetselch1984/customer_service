class Message < ApplicationRecord
  belongs_to :user
  belongs_to :root, class_name: 'Message', foreign_key: 'root_id', optional: true
  belongs_to :parent, class_name: 'Message', foreign_key: 'parent_id', optional: true

  before_validation do
    if parent
      self.user = parent.user
      self.root = parent.root || parent
    end
  end

  validates :subject, presence: true, length: { maximum: 80 }
  validates :body, presence: true, length: { maximum: 800 }
end
