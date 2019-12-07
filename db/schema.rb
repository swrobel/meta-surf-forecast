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

ActiveRecord::Schema.define(version: 2019_12_07_012940) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "api_requests", id: :serial, force: :cascade do |t|
    t.string "request"
    t.json "response"
    t.boolean "success"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "batch_id"
    t.float "response_time"
    t.string "requestable_type"
    t.bigint "requestable_id"
    t.string "service"
    t.integer "retries"
    t.index ["batch_id"], name: "index_api_requests_on_batch_id"
    t.index ["requestable_type", "requestable_id"], name: "index_api_requests_on_requestable_type_and_requestable_id"
  end

  create_table "friendly_id_slugs", id: :serial, force: :cascade do |t|
    t.string "slug", null: false
    t.integer "sluggable_id", null: false
    t.string "sluggable_type", limit: 50
    t.string "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
    t.index ["sluggable_type", "sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_type_and_sluggable_id"
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
    t.integer "sort_order"
    t.index ["slug"], name: "index_regions_on_slug", unique: true
    t.index ["sort_order"], name: "index_regions_on_sort_order", unique: true
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
    t.integer "surfline_v1_id"
    t.integer "msw_id"
    t.integer "spitcast_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug"
    t.bigint "subregion_id"
    t.string "spitcast_slug"
    t.integer "sort_order"
    t.string "surfline_v2_id"
    t.index ["msw_id", "surfline_v1_id", "surfline_v2_id", "spitcast_id"], name: "spots_unique_index", unique: true
    t.index ["subregion_id", "slug"], name: "index_spots_on_subregion_id_and_slug", unique: true
    t.index ["subregion_id", "sort_order"], name: "index_spots_on_subregion_id_and_sort_order", unique: true
  end

  create_table "subregions", force: :cascade do |t|
    t.string "name"
    t.string "slug"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "timezone"
    t.bigint "region_id"
    t.integer "sort_order"
    t.index ["region_id", "slug"], name: "index_subregions_on_region_id_and_slug", unique: true
    t.index ["region_id", "sort_order"], name: "index_subregions_on_region_id_and_sort_order", unique: true
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

  create_table "surfline_v2s", force: :cascade do |t|
    t.bigint "spot_id", null: false
    t.datetime "timestamp"
    t.decimal "min_height"
    t.decimal "max_height"
    t.integer "swell_rating"
    t.integer "wind_rating"
    t.bigint "api_request_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["api_request_id"], name: "index_surfline_v2s_on_api_request_id"
    t.index ["spot_id", "timestamp"], name: "index_surfline_v2s_on_spot_id_and_timestamp"
  end

  create_table "update_batches", force: :cascade do |t|
    t.integer "concurrency"
    t.interval "duration"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
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

  add_foreign_key "api_requests", "update_batches", column: "batch_id"
  add_foreign_key "msws", "api_requests"
  add_foreign_key "msws", "spots"
  add_foreign_key "spitcasts", "api_requests"
  add_foreign_key "spitcasts", "spots"
  add_foreign_key "spots", "subregions"
  add_foreign_key "subregions", "regions"
  add_foreign_key "surfline_lolas", "api_requests"
  add_foreign_key "surfline_lolas", "spots"
  add_foreign_key "surfline_nearshores", "api_requests"
  add_foreign_key "surfline_nearshores", "spots"
  add_foreign_key "surfline_v2s", "api_requests"
  add_foreign_key "surfline_v2s", "spots"
  add_foreign_key "water_qualities", "water_quality_departments", column: "dept_id"

  create_view "all_forecasts", materialized: true, sql_definition: <<-SQL
      SELECT 'msw'::text AS service,
      msws.spot_id,
      msws."timestamp",
      msws.min_height,
      msws.max_height,
      ((msws.min_height + msws.max_height) / (2)::numeric) AS avg_height,
      msws.rating,
      msws.updated_at
     FROM msws
  UNION
   SELECT 'spitcast'::text AS service,
      spitcasts.spot_id,
      spitcasts."timestamp",
      avg(spitcasts.height) OVER w AS min_height,
      avg(spitcasts.height) OVER w AS max_height,
      avg(spitcasts.height) OVER w AS avg_height,
      (avg(spitcasts.rating) OVER w - 0.5) AS rating,
      spitcasts.updated_at
     FROM spitcasts
    WINDOW w AS (PARTITION BY spitcasts.spot_id ORDER BY spitcasts."timestamp" ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING)
  UNION
   SELECT 'lola'::text AS service,
      surfline_lolas.spot_id,
      surfline_lolas."timestamp",
      surfline_lolas.min_height,
      surfline_lolas.max_height,
      ((surfline_lolas.min_height + surfline_lolas.max_height) / (2)::numeric) AS avg_height,
      ((surfline_lolas.swell_rating * (5)::numeric) *
          CASE
              WHEN surfline_lolas.optimal_wind THEN (1)::numeric
              ELSE 0.5
          END) AS rating,
      surfline_lolas.updated_at
     FROM surfline_lolas
  UNION
   SELECT 'nearshore'::text AS service,
      surfline_nearshores.spot_id,
      surfline_nearshores."timestamp",
      surfline_nearshores.min_height,
      surfline_nearshores.max_height,
      ((surfline_nearshores.min_height + surfline_nearshores.max_height) / (2)::numeric) AS avg_height,
      ((surfline_nearshores.swell_rating * (5)::numeric) *
          CASE
              WHEN surfline_nearshores.optimal_wind THEN (1)::numeric
              ELSE 0.5
          END) AS rating,
      surfline_nearshores.updated_at
     FROM surfline_nearshores
  UNION
   SELECT 'surfline_v2'::text AS service,
      surfline_v2s.spot_id,
      surfline_v2s."timestamp",
      avg(surfline_v2s.min_height) OVER w AS min_height,
      avg(surfline_v2s.max_height) OVER w AS max_height,
      ((avg(surfline_v2s.min_height) OVER w + avg(surfline_v2s.max_height) OVER w) / (2)::numeric) AS avg_height,
      ((avg(surfline_v2s.swell_rating) OVER w + avg(surfline_v2s.wind_rating) OVER w) + 0.5) AS rating,
      surfline_v2s.updated_at
     FROM surfline_v2s
    WINDOW w AS (PARTITION BY surfline_v2s.spot_id ORDER BY surfline_v2s."timestamp" ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING);
  SQL
  add_index "all_forecasts", ["spot_id"], name: "index_all_forecasts_on_spot_id"
  add_index "all_forecasts", ["timestamp"], name: "index_all_forecasts_on_timestamp"

  create_view "batch_stats", materialized: true, sql_definition: <<-SQL
      SELECT b.id,
      b.concurrency,
      b.duration,
      sum(
          CASE
              WHEN r.success THEN 1
              ELSE 0
          END) AS success,
      sum(r.retries) AS retry,
      sum(
          CASE
              WHEN r.success THEN 0
              ELSE 1
          END) AS fail,
      sum(
          CASE
              WHEN ((r.service)::text = 'Msw'::text) THEN r.retries
              ELSE 0
          END) AS msw_retry,
      sum(
          CASE
              WHEN ((r.success = false) AND ((r.service)::text = 'Msw'::text)) THEN 1
              ELSE 0
          END) AS msw_fail,
      sum(
          CASE
              WHEN ((r.service)::text = ANY ((ARRAY['SurflineLola'::character varying, 'SurflineNearshore'::character varying])::text[])) THEN r.retries
              ELSE 0
          END) AS surfline_v1_retry,
      sum(
          CASE
              WHEN ((r.success = false) AND ((r.service)::text = ANY ((ARRAY['SurflineLola'::character varying, 'SurflineNearshore'::character varying])::text[]))) THEN 1
              ELSE 0
          END) AS surfline_v1_fail,
      sum(
          CASE
              WHEN ((r.service)::text = 'SurflineV2'::text) THEN r.retries
              ELSE 0
          END) AS surfline_v2_retry,
      sum(
          CASE
              WHEN ((r.success = false) AND ((r.service)::text = 'SurflineV2'::text)) THEN 1
              ELSE 0
          END) AS surfline_v2_fail,
      sum(
          CASE
              WHEN ((r.service)::text = 'Spitcast'::text) THEN r.retries
              ELSE 0
          END) AS spitcast_retry,
      sum(
          CASE
              WHEN ((r.success = false) AND ((r.service)::text = 'Spitcast'::text)) THEN 1
              ELSE 0
          END) AS spitcast_fail
     FROM (api_requests r
       JOIN update_batches b ON ((r.batch_id = b.id)))
    GROUP BY b.id, b.concurrency, b.duration;
  SQL
end
