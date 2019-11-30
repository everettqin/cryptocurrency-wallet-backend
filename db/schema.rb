# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_11_29_111548) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "hstore"
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "transactions", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.decimal "amount"
    t.string "type"
    t.string "state"
    t.uuid "source_user_id"
    t.uuid "target_user_id"
    t.datetime "processed_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["processed_at"], name: "index_transactions_on_processed_at"
    t.index ["source_user_id"], name: "index_transactions_on_source_user_id"
    t.index ["state"], name: "index_transactions_on_state"
    t.index ["target_user_id"], name: "index_transactions_on_target_user_id"
    t.index ["type"], name: "index_transactions_on_type"
  end

  create_table "users", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.string "email"
    t.string "bitcoin_wallet_id"
    t.decimal "bitcoin_wallet_balance"
    t.string "ethereum_wallet_id"
    t.decimal "ethereum_wallet_balance"
    t.decimal "max_transaction_limit"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["bitcoin_wallet_id"], name: "index_users_on_bitcoin_wallet_id"
    t.index ["email"], name: "index_users_on_email"
    t.index ["ethereum_wallet_id"], name: "index_users_on_ethereum_wallet_id"
    t.index ["name"], name: "index_users_on_name"
  end

end
