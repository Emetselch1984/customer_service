class Message < ApplicationRecord
  attr_accessor :child_nodes
  belongs_to :user
  belongs_to :staff, class_name: 'User', foreign_key: 'staff_id', optional: true
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
  scope :not_deleted, -> { where(deleted: false) }
  scope :deleted, -> { where(deleted: true) }
  scope :sorted, -> { order(created_at: :desc) }

  def tree
    return @tree if @tree
    r = root || self
    messages = Message.where(root_id: r.id).select(:id,:parent_id,:subject)
    @tree= SimpleTree.new(r,messages)
    binding.pry
  end
end
