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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20140724195526) do

  create_table "players", :force => true do |t|
    t.string   "name"
    t.string   "position"
    t.string   "picture_url"
    t.string   "team"
    t.string   "stat_year"
    t.integer  "rushes"
    t.integer  "rush_yards"
    t.integer  "rush_tds"
    t.integer  "targets"
    t.integer  "receptions"
    t.integer  "receiving_yards"
    t.integer  "receiving_tds"
    t.integer  "completions"
    t.integer  "attempts"
    t.integer  "pass_yards"
    t.integer  "pass_tds"
    t.integer  "interceptions"
    t.integer  "sacks"
    t.integer  "fumble_recoveries"
    t.integer  "points_against"
    t.integer  "yards_against"
    t.integer  "kicking_attempts_1_to_39"
    t.integer  "kicking_completions_1_to_39"
    t.integer  "kicking_attempts_40_to_49"
    t.integer  "kicking_completions_40_to_49"
    t.integer  "kicking_attempts_over_50"
    t.integer  "kicking_completions_over_50"
    t.integer  "kicking_attempts_total"
    t.integer  "kicking_completions_total"
    t.integer  "kicking_attempts_XP"
    t.integer  "kicking_completions_XP"
    t.integer  "fpoints"
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
    t.integer  "fumble_lost"
  end

end
