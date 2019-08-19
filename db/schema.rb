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

ActiveRecord::Schema.define(version: 2019_08_19_101145) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.integer "subtype"
    t.integer "a"
    t.integer "b"
    t.integer "c"
    t.integer "d"
    t.integer "e"
    t.bigint "privilege_id"
    t.index ["privilege_id"], name: "index_categories_on_privilege_id"
  end

  create_table "privileges", force: :cascade do |t|
    t.integer "salary"
    t.integer "year"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "country_code"
    t.integer "redundancy"
    t.integer "role"
    t.integer "salary_year"
  end

end
