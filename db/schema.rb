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

ActiveRecord::Schema.define(version: 20160419152512) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "api_requests", force: :cascade do |t|
    t.string   "request"
    t.json     "response"
    t.boolean  "success"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "msws", force: :cascade do |t|
    t.integer  "spot_id"
    t.datetime "timestamp"
    t.decimal  "min_height"
    t.decimal  "max_height"
    t.integer  "rating"
    t.integer  "wind_effect"
    t.integer  "api_request_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "msws", ["api_request_id"], name: "index_msws_on_api_request_id", using: :btree
  add_index "msws", ["spot_id", "timestamp"], name: "index_msws_on_spot_id_and_timestamp", using: :btree

  create_table "spitcasts", force: :cascade do |t|
    t.integer  "spot_id"
    t.datetime "timestamp"
    t.decimal  "height"
    t.integer  "rating"
    t.integer  "api_request_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "spitcasts", ["api_request_id"], name: "index_spitcasts_on_api_request_id", using: :btree
  add_index "spitcasts", ["spot_id", "timestamp"], name: "index_spitcasts_on_spot_id_and_timestamp", using: :btree

  create_table "spots", force: :cascade do |t|
    t.string   "name"
    t.float    "lat"
    t.float    "lon"
    t.integer  "surfline_id"
    t.integer  "msw_id"
    t.integer  "spitcast_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "surflines", force: :cascade do |t|
    t.integer  "spot_id"
    t.datetime "timestamp"
    t.decimal  "min_height"
    t.decimal  "max_height"
    t.decimal  "swell_rating"
    t.boolean  "optimal_wind"
    t.integer  "api_request_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "surflines", ["api_request_id"], name: "index_surflines_on_api_request_id", using: :btree
  add_index "surflines", ["spot_id", "timestamp"], name: "index_surflines_on_spot_id_and_timestamp", using: :btree

  create_table "water_qualities", force: :cascade do |t|
    t.integer  "dept_id"
    t.string   "site_id"
    t.datetime "timestamp"
    t.string   "name"
    t.boolean  "ok"
    t.string   "comments"
    t.float    "lat"
    t.float    "lon"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "water_qualities", ["dept_id", "site_id", "timestamp"], name: "index_water_qualities_on_dept_id_and_site_id_and_timestamp", using: :btree

  create_table "water_quality_departments", force: :cascade do |t|
    t.string   "name"
    t.string   "code"
    t.string   "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "msws", "api_requests"
  add_foreign_key "msws", "spots"
  add_foreign_key "spitcasts", "api_requests"
  add_foreign_key "spitcasts", "spots"
  add_foreign_key "surflines", "api_requests"
  add_foreign_key "surflines", "spots"
  add_foreign_key "water_qualities", "water_quality_departments", column: "dept_id"
end
