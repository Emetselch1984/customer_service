class AlterMessages < ActiveRecord::Migration[6.1]
  def change
    add_column :messages, :staff_id, :bigint
  end
end
