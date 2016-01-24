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

ActiveRecord::Schema.define(version: 20160124055217) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "msws", force: :cascade do |t|
    t.integer  "spot_id"
    t.datetime "timestamp"
    t.decimal  "min_height"
    t.decimal  "max_height"
    t.integer  "rating"
    t.integer  "wind_effect"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "spots", force: :cascade do |t|
    t.string   "name"
    t.float    "lat"
    t.float    "lon"
    t.integer  "surfline_id"
    t.integer  "msw_id"
    t.integer  "spitcast_id"
    t.integer  "wunder_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "surflines", force: :cascade do |t|
    t.integer  "spot_id"
    t.datetime "timestamp"
    t.decimal  "min_height"
    t.decimal  "max_height"
    t.string   "quality"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
