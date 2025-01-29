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

ActiveRecord::Schema[7.2].define(version: 2025_01_29_072008) do
  create_table "matches", force: :cascade do |t|
    t.integer "tournament_id", null: false
    t.integer "player1_id", null: false
    t.integer "player2_id", null: false
    t.integer "round"
    t.string "result"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["player1_id"], name: "index_matches_on_player1_id"
    t.index ["player2_id"], name: "index_matches_on_player2_id"
    t.index ["tournament_id"], name: "index_matches_on_tournament_id"
  end

  create_table "participants", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "tournament_id", null: false
    t.integer "score"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tournament_id"], name: "index_participants_on_tournament_id"
    t.index ["user_id"], name: "index_participants_on_user_id"
  end

  create_table "tournaments", force: :cascade do |t|
    t.string "name"
    t.datetime "date"
    t.integer "max_participants"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "name", default: "", null: false
    t.boolean "admin", default: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "matches", "player1s"
  add_foreign_key "matches", "player2s"
  add_foreign_key "matches", "tournaments"
  add_foreign_key "participants", "tournaments"
  add_foreign_key "participants", "users"
end
