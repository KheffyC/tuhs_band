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

ActiveRecord::Schema[7.0].define(version: 2023_09_05_053328) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "directors", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "phone_number"
    t.string "title"
    t.string "school_name"
    t.string "school_address"
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_directors_on_email", unique: true
    t.index ["reset_password_token"], name: "index_directors_on_reset_password_token", unique: true
  end

  create_table "districts", force: :cascade do |t|
    t.string "name", limit: 100, null: false
    t.string "city"
    t.string "state"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_districts_on_name"
  end

  create_table "programs", force: :cascade do |t|
    t.string "name", limit: 100, null: false
    t.string "description"
    t.date "year_established"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "school_id", null: false
    t.string "main_gallery_image_url"
    t.string "page_image_url"
    t.string "hero_title", limit: 100
    t.string "detailed_description"
    t.string "short_name"
    t.index ["name"], name: "index_programs_on_name"
    t.index ["school_id"], name: "index_programs_on_school_id"
  end

  create_table "schools", force: :cascade do |t|
    t.string "name", limit: 100, null: false
    t.date "established"
    t.string "description"
    t.string "city"
    t.string "state"
    t.string "district"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "district_id"
    t.string "hero_title", limit: 100
    t.string "call_to_action"
    t.string "contact_us"
    t.index ["district_id"], name: "index_schools_on_district_id"
    t.index ["name"], name: "index_schools_on_name"
  end

  add_foreign_key "programs", "schools"
  add_foreign_key "schools", "districts"
end
