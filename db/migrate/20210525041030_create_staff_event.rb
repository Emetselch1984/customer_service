class CreateStaffEvent < ActiveRecord::Migration[6.1]
  def change
    create_table :staff_events do |t|
      t.references :user, null: false, index: false, foreign_key: true
      t.string :type, null: false
      t.datetime :created_at, null: false
    end

    add_index :staff_events, :created_at
    add_index :staff_events, %i[user_id created_at]
  end
end
