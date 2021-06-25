# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20_210_622_023_256) do
  create_table 'addresses', charset: 'utf8mb4', collation: 'utf8mb4_0900_ai_ci', force: :cascade do |t|
    t.bigint 'user_id', null: false
    t.string 'type', null: false
    t.string 'postal_code', null: false
    t.string 'prefecture', null: false
    t.string 'city', null: false
    t.string 'address1', null: false
    t.string 'address2', null: false
    t.string 'company_name', default: '', null: false
    t.string 'division_name', default: '', null: false
    t.index ['city'], name: 'index_addresses_on_city'
    t.index %w[prefecture city], name: 'index_addresses_on_prefecture_and_city'
    t.index %w[type city], name: 'index_addresses_on_type_and_city'
    t.index %w[type prefecture city], name: 'index_addresses_on_type_and_prefecture_and_city'
    t.index %w[type user_id], name: 'index_addresses_on_type_and_user_id', unique: true
    t.index ['user_id'], name: 'index_addresses_on_user_id'
  end

  create_table 'phones', charset: 'utf8mb4', collation: 'utf8mb4_0900_ai_ci', force: :cascade do |t|
    t.bigint 'user_id', null: false
    t.bigint 'address_id'
    t.string 'number', null: false
    t.string 'number_for_index', null: false
    t.boolean 'primary', default: false, null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['address_id'], name: 'index_phones_on_address_id'
    t.index ['number_for_index'], name: 'index_phones_on_number_for_index'
    t.index ['user_id'], name: 'index_phones_on_user_id'
  end

  create_table 'staff_events', charset: 'utf8mb4', collation: 'utf8mb4_0900_ai_ci', force: :cascade do |t|
    t.bigint 'user_id', null: false
    t.string 'type', null: false
    t.datetime 'created_at', null: false
    t.index ['created_at'], name: 'index_staff_events_on_created_at'
    t.index %w[user_id created_at], name: 'index_staff_events_on_user_id_and_created_at'
  end

  create_table 'users', charset: 'utf8mb4', collation: 'utf8mb4_0900_ai_ci', force: :cascade do |t|
    t.string 'email', null: false
    t.string 'crypted_password'
    t.string 'salt'
    t.string 'type', default: 'Staff'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.string 'family_name'
    t.string 'given_name'
    t.string 'family_name_kana'
    t.string 'given_name_kana'
    t.date 'start_date'
    t.date 'end_date'
    t.boolean 'suspended', default: false
    t.string 'gender'
    t.date 'birthday'
    t.integer 'birth_year'
    t.integer 'birth_month'
    t.integer 'birth_mday'
    t.index %w[birth_mday family_name_kana given_name_kana], name: 'index_customers_on_birth_mday_and_furigana'
    t.index %w[birth_mday given_name_kana], name: 'index_users_on_birth_mday_and_given_name_kana'
    t.index %w[birth_month birth_mday], name: 'index_users_on_birth_month_and_birth_mday'
    t.index %w[birth_month family_name_kana given_name_kana], name: 'index_customers_on_birth_month_and_furigana'
    t.index %w[birth_month given_name_kana], name: 'index_users_on_birth_month_and_given_name_kana'
    t.index %w[birth_year birth_month birth_mday],
            name: 'index_users_on_birth_year_and_birth_month_and_birth_mday'
    t.index %w[birth_year family_name_kana given_name_kana], name: 'index_customers_on_birth_year_and_furigana'
    t.index %w[birth_year given_name_kana], name: 'index_users_on_birth_year_and_given_name_kana'
    t.index ['email'], name: 'index_users_on_email', unique: true
    t.index ['given_name_kana'], name: 'index_users_on_given_name_kana'
  end

  add_foreign_key 'addresses', 'users'
  add_foreign_key 'phones', 'addresses'
  add_foreign_key 'phones', 'users'
  add_foreign_key 'staff_events', 'users'
end
