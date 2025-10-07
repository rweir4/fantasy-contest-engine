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

ActiveRecord::Schema[8.0].define(version: 2025_10_07_202801) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "contests", force: :cascade do |t|
    t.string "name"
    t.decimal "entry"
    t.integer "salary_cap"
    t.datetime "start_time"
    t.string "status"
    t.integer "cached_leader_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "lineup_players", force: :cascade do |t|
    t.bigint "lineup_id", null: false
    t.bigint "player_id", null: false
    t.string "position_slot"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["lineup_id"], name: "index_lineup_players_on_lineup_id"
    t.index ["player_id"], name: "index_lineup_players_on_player_id"
  end

  create_table "lineups", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "contest_id", null: false
    t.decimal "total_score"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["contest_id"], name: "index_lineups_on_contest_id"
    t.index ["user_id"], name: "index_lineups_on_user_id"
  end

  create_table "player_stats", force: :cascade do |t|
    t.bigint "player_id", null: false
    t.integer "game_week"
    t.jsonb "stats"
    t.decimal "fantasy_points"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["player_id"], name: "index_player_stats_on_player_id"
  end

  create_table "players", force: :cascade do |t|
    t.string "name"
    t.string "position"
    t.decimal "salary"
    t.string "team"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.decimal "balance"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "lineup_players", "lineups"
  add_foreign_key "lineup_players", "players"
  add_foreign_key "lineups", "contests"
  add_foreign_key "lineups", "users"
  add_foreign_key "player_stats", "players"
end
