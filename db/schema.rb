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

ActiveRecord::Schema.define(version: 20170618230016) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "api_requests", id: :serial, force: :cascade do |t|
    t.string "request"
    t.json "response"
    t.boolean "success"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "friendly_id_slugs", id: :serial, force: :cascade do |t|
    t.string "slug", null: false
    t.integer "sluggable_id", null: false
    t.string "sluggable_type", limit: 50
    t.string "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
    t.index ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id"
    t.index ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type"
  end

  create_table "msws", id: :serial, force: :cascade do |t|
    t.integer "spot_id"
    t.datetime "timestamp"
    t.decimal "min_height"
    t.decimal "max_height"
    t.integer "rating"
    t.integer "wind_effect"
    t.integer "api_request_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["api_request_id"], name: "index_msws_on_api_request_id"
    t.index ["spot_id", "timestamp"], name: "index_msws_on_spot_id_and_timestamp"
  end

  create_table "regions", force: :cascade do |t|
    t.string "name"
    t.string "slug"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["slug"], name: "index_regions_on_slug", unique: true
  end

  create_table "spitcasts", id: :serial, force: :cascade do |t|
    t.integer "spot_id"
    t.datetime "timestamp"
    t.decimal "height"
    t.integer "rating"
    t.integer "api_request_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["api_request_id"], name: "index_spitcasts_on_api_request_id"
    t.index ["spot_id", "timestamp"], name: "index_spitcasts_on_spot_id_and_timestamp"
  end

  create_table "spots", id: :serial, force: :cascade do |t|
    t.string "name"
    t.float "lat"
    t.float "lon"
    t.integer "surfline_id"
    t.integer "msw_id"
    t.integer "spitcast_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug"
    t.bigint "region_id"
    t.string "msw_slug"
    t.string "spitcast_slug"
    t.string "surfline_slug"
    t.index ["msw_id", "surfline_id", "spitcast_id"], name: "index_spots_on_msw_id_and_surfline_id_and_spitcast_id", unique: true
    t.index ["region_id"], name: "index_spots_on_region_id"
    t.index ["slug"], name: "index_spots_on_slug", unique: true
  end

  create_table "surfline_lolas", id: :serial, force: :cascade do |t|
    t.integer "spot_id"
    t.datetime "timestamp"
    t.decimal "min_height"
    t.decimal "max_height"
    t.decimal "swell_rating"
    t.boolean "optimal_wind"
    t.integer "api_request_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["api_request_id"], name: "index_surfline_lolas_on_api_request_id"
    t.index ["spot_id", "timestamp"], name: "index_surfline_lolas_on_spot_id_and_timestamp"
  end

  create_table "surfline_nearshores", id: :serial, force: :cascade do |t|
    t.integer "spot_id"
    t.datetime "timestamp"
    t.decimal "min_height"
    t.decimal "max_height"
    t.decimal "swell_rating"
    t.boolean "optimal_wind"
    t.integer "api_request_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["api_request_id"], name: "index_surfline_nearshores_on_api_request_id"
    t.index ["spot_id", "timestamp"], name: "index_surfline_nearshores_on_spot_id_and_timestamp"
  end

  create_table "water_qualities", id: :serial, force: :cascade do |t|
    t.integer "dept_id"
    t.string "site_id"
    t.datetime "timestamp"
    t.string "name"
    t.boolean "ok"
    t.string "comments"
    t.float "lat"
    t.float "lon"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["dept_id", "site_id", "timestamp"], name: "index_water_qualities_on_dept_id_and_site_id_and_timestamp"
  end

  create_table "water_quality_departments", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "code"
    t.string "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "msws", "api_requests"
  add_foreign_key "msws", "spots"
  add_foreign_key "spitcasts", "api_requests"
  add_foreign_key "spitcasts", "spots"
  add_foreign_key "spots", "regions"
  add_foreign_key "surfline_lolas", "api_requests"
  add_foreign_key "surfline_lolas", "spots"
  add_foreign_key "surfline_nearshores", "api_requests"
  add_foreign_key "surfline_nearshores", "spots"
  add_foreign_key "water_qualities", "water_quality_departments", column: "dept_id"
end
