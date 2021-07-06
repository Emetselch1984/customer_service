class StaffMessage < Message
  scope :unprocessed, -> { where(status: 'new', deleted: false) }
end
