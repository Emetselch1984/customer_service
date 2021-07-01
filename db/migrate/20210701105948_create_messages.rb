class CreateMessages < ActiveRecord::Migration[6.1]
  def change
    create_table :messages do |t|
      t.references :user                          # 職員への外部キー
      t.bigint :root_id                                  # Messageへの外部キー
      t.bigint :parent_id                                # Messageへの外部キー
      t.string :type, null: false                         # 継承カラム
      t.string :status, null: false, default: 'new'       # 状態（職員向け）
      t.string :subject, null: false                      # 件名
      t.text :body                                        # 本⽂
      t.text :remarks                                     # 備考（職員向け）
      t.boolean :discarded, null: false, default: false   # 顧客側の削除フラグ
      t.boolean :deleted, null: false, default: false     # 職員側の削除フラグ

      t.timestamps
    end

    add_index :messages, %i[type user_id]
    add_index :messages, %i[user_id discarded created_at]
    add_index :messages, %i[user_id deleted created_at]
    add_index :messages, %i[user_id deleted status created_at],
              name: 'index_messages_on_c_d_s_c'
    add_index :messages, %i[root_id deleted created_at]
    add_foreign_key :messages, :users
    add_foreign_key :messages, :messages, column: 'root_id'
    add_foreign_key :messages, :messages, column: 'parent_id'
  end
end
