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

ActiveRecord::Schema.define(version: 20141222162041) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: true do |t|
    t.string   "name",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "operations", force: true do |t|
    t.date     "date",                                    null: false
    t.decimal  "sum",            precision: 15, scale: 2, null: false
    t.string   "source",                                  null: false
    t.integer  "category_id",                             null: false
    t.integer  "subcategory_id"
    t.string   "comment"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "operations", ["date"], name: "index_operations_on_date", using: :btree

  create_table "subcategories", force: true do |t|
    t.string   "name",        null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "category_id", null: false
  end

end