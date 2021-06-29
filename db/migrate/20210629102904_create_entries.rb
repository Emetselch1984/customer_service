class CreateEntries < ActiveRecord::Migration[6.1]
  def change
    create_table :entries do |t|
      t.references :program, null: false, index: false
      t.references :user, null: false
      t.boolean :approved, null: false, default: false # 承認済みフラグ
      t.boolean :canceled, null: false, default: false # 取り消しフラグ

      t.timestamps
    end

    add_index :entries, %i[program_id user_id], unique: true
    add_foreign_key :entries, :programs
    add_foreign_key :entries, :users
  end
end
