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

ActiveRecord::Schema.define(version: 20140222171540) do

  create_table "items", force: true do |t|
    t.string   "description"
    t.integer  "quantity"
    t.text     "comments"
    t.string   "url"
    t.integer  "quantity_purchased"
    t.datetime "date_deleted"
    t.text     "reason_deleted"
    t.integer  "list_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "lists", force: true do |t|
    t.string   "listname"
    t.integer  "listType_id"
    t.date     "eventdate"
    t.integer  "user_id"
    t.datetime "datedeleted"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "listtypes", force: true do |t|
    t.string   "listtype"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "purchases", force: true do |t|
    t.integer  "item_id"
    t.integer  "purchase_user_id"
    t.datetime "date_purchased"
    t.integer  "quantity_purchased"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "relationships", force: true do |t|
    t.integer  "user_id"
    t.integer  "shared_user_id"
    t.integer  "relation_type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "relationtypes", force: true do |t|
    t.string   "relation_type_desc"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "shared_lists", force: true do |t|
    t.integer  "list_id"
    t.integer  "shared_user_id"
    t.datetime "shared_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "states", force: true do |t|
    t.string   "state"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "firstname"
    t.string   "lastname"
    t.date     "birthdate"
    t.string   "address"
    t.string   "city"
    t.integer  "state_id"
    t.integer  "zip"
    t.string   "email"
    t.string   "password"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
