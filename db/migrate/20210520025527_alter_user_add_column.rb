class AlterUserAddColumn < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :family_name, :string             # 姓
    add_column :users, :given_name, :string # 名
    add_column :users, :family_name_kana, :string # 姓（カナ）
    add_column :users, :given_name_kana, :string # 名（カナ）
    add_column :users,  :start_date, :date                   # 開始日
    add_column :users,  :end_date, :date
    add_column :users,  :suspended, :boolean, default: false
  end
end
