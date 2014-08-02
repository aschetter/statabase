# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20140802062446) do

  create_table "advs", force: true do |t|
    t.integer  "player_id"
    t.string   "br_id"
    t.float    "per"
    t.float    "ts_pct"
    t.float    "efg_pct"
    t.float    "ft_ar"
    t.float    "three_ar"
    t.float    "orb_pct"
    t.float    "drb_pct"
    t.float    "trb_pct"
    t.float    "ast_pct"
    t.float    "stl_pct"
    t.float    "blk_pct"
    t.float    "tov_pct"
    t.float    "usg_pct"
    t.float    "o_rtg"
    t.float    "d_rtg"
    t.float    "ows"
    t.float    "dws"
    t.float    "ws"
    t.float    "ws_48"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "memberships", force: true do |t|
    t.integer  "player_id"
    t.integer  "team_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "players", force: true do |t|
    t.string   "br_id"
    t.string   "name"
    t.integer  "salary"
    t.integer  "number"
    t.string   "position"
    t.string   "height"
    t.string   "weight"
    t.string   "birth_date"
    t.string   "experience"
    t.string   "college"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "season_teams", force: true do |t|
    t.integer  "team_id"
    t.integer  "season_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "seasons", force: true do |t|
    t.integer  "year"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "stats", force: true do |t|
    t.integer  "player_id"
    t.string   "br_id"
    t.integer  "age"
    t.integer  "gp"
    t.integer  "gs"
    t.integer  "min"
    t.integer  "fg_made"
    t.integer  "fg_att"
    t.float    "fg_pct"
    t.integer  "three_made"
    t.integer  "three_att"
    t.float    "three_pct"
    t.integer  "two_made"
    t.integer  "two_att"
    t.float    "two_pct"
    t.integer  "ft_made"
    t.integer  "ft_att"
    t.float    "ft_pct"
    t.integer  "orb"
    t.integer  "drb"
    t.integer  "trb"
    t.integer  "ast"
    t.integer  "stl"
    t.integer  "blk"
    t.integer  "tov"
    t.integer  "pf"
    t.integer  "pts"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "teams", force: true do |t|
    t.string   "br_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
