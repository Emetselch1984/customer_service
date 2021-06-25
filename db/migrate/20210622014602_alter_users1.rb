class AlterUsers1 < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :birth_year, :integer
    add_column :users, :birth_month, :integer
    add_column :users, :birth_mday, :integer

    add_index :users, %i[birth_year birth_month birth_mday]
    add_index :users, %i[birth_month birth_mday]
    add_index :users, :given_name_kana
    add_index :users, %i[birth_year family_name_kana given_name_kana],
              name: 'index_customers_on_birth_year_and_furigana'
    add_index :users, %i[birth_year given_name_kana]
    add_index :users,
              %i[birth_month family_name_kana given_name_kana],
              name: 'index_customers_on_birth_month_and_furigana'
    add_index :users, %i[birth_month given_name_kana]
    add_index :users, %i[birth_mday family_name_kana given_name_kana],
              name: 'index_customers_on_birth_mday_and_furigana'
    add_index :users, %i[birth_mday given_name_kana]
  end
end
