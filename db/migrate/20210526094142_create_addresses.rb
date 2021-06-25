class CreateAddresses < ActiveRecord::Migration[6.1]
  def change
    create_table :addresses do |t|
      t.references :user, null: false
      t.string :type, null: false
      t.string :postal_code, null: false
      t.string :prefecture, null: false
      t.string :city, null: false
      t.string :address1, null: false
      t.string :address2, null: false
      t.string :company_name, null: false, default: ''
      t.string :division_name, null: false, default: ''
    end
    add_index :addresses, %i[type user_id], unique: true
    add_foreign_key :addresses, :users
  end
end
