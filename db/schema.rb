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

ActiveRecord::Schema[7.0].define(version: 2023_04_09_100000) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "accounts", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "user_id", null: false
    t.string "account_type", default: "current"
    t.string "account_number", null: false
    t.float "balance", default: 0.0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_number"], name: "index_accounts_on_account_number", unique: true
    t.index ["account_type"], name: "index_accounts_on_account_type"
    t.index ["balance"], name: "index_accounts_on_balance"
    t.index ["user_id", "balance"], name: "index_accounts_on_user_id_and_balance"
    t.index ["user_id"], name: "index_accounts_on_user_id"
  end

  create_table "transactions", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.float "amount"
    t.string "purpose"
    t.string "account_sender_id", null: false
    t.string "account_recipient_id", null: false
    t.uuid "sender_id", null: false
    t.uuid "recipient_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_recipient_id"], name: "index_transactions_on_account_recipient_id"
    t.index ["account_sender_id"], name: "index_transactions_on_account_sender_id"
    t.index ["amount", "sender_id", "recipient_id"], name: "index_transactions_on_amount_and_sender_id_and_recipient_id"
    t.index ["amount"], name: "index_transactions_on_amount"
    t.index ["recipient_id"], name: "index_transactions_on_recipient_id"
    t.index ["sender_id", "recipient_id"], name: "index_transactions_on_sender_id_and_recipient_id"
    t.index ["sender_id"], name: "index_transactions_on_sender_id"
  end

  create_table "users", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "username"
    t.string "authentication_token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["authentication_token"], name: "index_users_on_authentication_token"
    t.index ["email"], name: "index_users_on_email"
    t.index ["name"], name: "index_users_on_name"
    t.index ["username", "authentication_token"], name: "index_users_on_username_and_authentication_token"
    t.index ["username"], name: "index_users_on_username"
  end

  add_foreign_key "accounts", "users"
  add_foreign_key "transactions", "accounts", column: "account_recipient_id", primary_key: "account_number"
  add_foreign_key "transactions", "accounts", column: "account_sender_id", primary_key: "account_number"
  add_foreign_key "transactions", "users", column: "recipient_id"
  add_foreign_key "transactions", "users", column: "sender_id"
end
