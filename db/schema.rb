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

ActiveRecord::Schema.define(version: 20140519150548) do

  create_table "cars", force: true do |t|
    t.integer  "model_id",         limit: 10, precision: 10, scale: 0, null: false
    t.integer  "country_id",       limit: 10, precision: 10, scale: 0
    t.datetime "assembling_date"
    t.string   "pts",              limit: 30
    t.decimal  "price",                       precision: 9,  scale: 2, null: false
    t.integer  "specification_id", limit: 10, precision: 10, scale: 0, null: false
    t.integer  "engine_id",        limit: 10, precision: 10, scale: 0, null: false
    t.string   "color",            limit: 7
  end

  create_table "countries", force: true do |t|
    t.string "name", limit: 30, null: false
  end

  create_table "employee", force: true do |t|
    t.integer  "person_id",   limit: 10, precision: 10, scale: 0, null: false
    t.integer  "position_id", limit: 10, precision: 10, scale: 0, null: false
    t.datetime "startdate",                                       null: false
    t.datetime "enddate"
    t.decimal  "salary",                 precision: 9,  scale: 2, null: false
  end

  create_table "engine", force: true do |t|
    t.string  "model",           limit: 40,                           null: false
    t.integer "power",           limit: 4,   precision: 4,  scale: 0, null: false
    t.integer "displacement",    limit: 5,   precision: 5,  scale: 0, null: false
    t.integer "typeofengine_id", limit: 10,  precision: 10, scale: 0, null: false
    t.string  "info",            limit: 150
  end

  create_table "insurance", force: true do |t|
    t.integer  "type_id",    limit: 10, precision: 10, scale: 0, null: false
    t.integer  "version_id", limit: 10, precision: 10, scale: 0, null: false
    t.decimal  "price",                 precision: 9,  scale: 2, null: false
    t.datetime "term_start"
    t.datetime "term_end"
  end

  create_table "manufacturers", force: true do |t|
    t.string "name", limit: 20, null: false
  end

  create_table "models", force: true do |t|
    t.string  "name",            limit: 20,                          null: false
    t.integer "manufacturer_id", limit: 10, precision: 10, scale: 0, null: false
  end

  create_table "options", force: true do |t|
    t.string  "name",     limit: 40,                            null: false
    t.integer "type_id",  limit: 10,   precision: 10, scale: 0, null: false
    t.string  "info",     limit: 4000,                          null: false
    t.decimal "price",                 precision: 9,  scale: 2, null: false
    t.integer "model_id",              precision: 38, scale: 0
  end

  create_table "options_orders", id: false, force: true do |t|
    t.integer "option_id", limit: 10, precision: 10, scale: 0, null: false
    t.integer "order_id",  limit: 10, precision: 10, scale: 0, null: false
  end

  create_table "orders", force: true do |t|
    t.integer  "car_id",         limit: 10, precision: 10, scale: 0,             null: false
    t.integer  "client_id",      limit: 10, precision: 10, scale: 0,             null: false
    t.integer  "manager_id",     limit: 10, precision: 10, scale: 0,             null: false
    t.datetime "order_date",                                                     null: false
    t.datetime "execution_date"
    t.integer  "insurance_id",   limit: 10, precision: 10, scale: 0
    t.integer  "status_id",                 precision: 38, scale: 0, default: 0
  end

  create_table "person", force: true do |t|
    t.string   "firstname",       limit: 30,                                       null: false
    t.string   "lastname",        limit: 30,                                       null: false
    t.string   "middlename",      limit: 30,                                       null: false
    t.datetime "dob",                                                              null: false
    t.string   "gender",          limit: 1
    t.string   "password_digest",                                                  null: false
    t.string   "email",           limit: 320,                                      null: false
    t.integer  "acs_level",                   precision: 38, scale: 0, default: 0, null: false
    t.string   "remember_token"
    t.string   "phone",           limit: 11
  end

  add_index "person", ["email"], name: "index_person_on_email", unique: true
  add_index "person", ["remember_token"], name: "index_person_on_remember_token"

  create_table "position", force: true do |t|
    t.string "name", limit: 30, null: false
  end

  create_table "preparation", force: true do |t|
    t.string  "name",    limit: 40,                            null: false
    t.integer "type_id", limit: 10,   precision: 10, scale: 0, null: false
    t.string  "info",    limit: 4000,                          null: false
    t.decimal "price",                precision: 9,  scale: 2, null: false
  end

  create_table "preparation_orders", id: false, force: true do |t|
    t.integer "preparation_id", limit: 10, precision: 10, scale: 0, null: false
    t.integer "order_id",       limit: 10, precision: 10, scale: 0, null: false
  end

  create_table "specifications", force: true do |t|
    t.string  "name",     limit: 40,                            null: false
    t.string  "info",     limit: 4000
    t.integer "model_id",              precision: 38, scale: 0
    t.integer "price",                 precision: 38, scale: 0
  end

  create_table "specs_engines", id: false, force: true do |t|
    t.integer "specification_id", precision: 38, scale: 0
    t.integer "engine_id",        precision: 38, scale: 0
  end

  create_table "statuses", force: true do |t|
    t.string "status"
  end

  create_table "telephone_numbers", force: true do |t|
    t.integer "person_id",       limit: 10, precision: 10, scale: 0, null: false
    t.string  "telephonenumber", limit: 20,                          null: false
  end

  create_table "type_of_engine", force: true do |t|
    t.string "name", limit: 20, null: false
  end

  create_table "type_of_insurance", force: true do |t|
    t.string "name", limit: 20, null: false
  end

  create_table "type_of_option", force: true do |t|
    t.string "name", limit: 20, null: false
  end

  create_table "type_of_preparation", force: true do |t|
    t.string "name", limit: nil, null: false
  end

  create_table "version_of_insurance", force: true do |t|
    t.string "name", limit: 80, null: false
  end

  add_foreign_key "cars", "countries", name: "sys_c0069575"
  add_foreign_key "cars", "engine", name: "sys_c0069577"
  add_foreign_key "cars", "models", name: "sys_c0087623"
  add_foreign_key "cars", "specifications", name: "sys_c0069576"

  add_foreign_key "employee", "person", name: "sys_c0069593"
  add_foreign_key "employee", "position", name: "sys_c0069594"

  add_foreign_key "engine", "type_of_engine", column: "typeofengine_id", name: "sys_c0069561"

  add_foreign_key "insurance", "type_of_insurance", column: "type_id", name: "sys_c0069607"
  add_foreign_key "insurance", "version_of_insurance", column: "version_id", name: "sys_c0069608"

  add_foreign_key "models", "manufacturers", name: "sys_c00179020"

  add_foreign_key "options", "type_of_option", column: "type_id", name: "sys_c0069636"

  add_foreign_key "options_orders", "options", name: "sys_c0069640"
  add_foreign_key "options_orders", "orders", name: "sys_c0069641"

  add_foreign_key "orders", "cars", name: "sys_c0069615"
  add_foreign_key "orders", "employee", column: "manager_id", name: "sys_c0069617"
  add_foreign_key "orders", "insurance", name: "sys_c0069618"
  add_foreign_key "orders", "person", column: "client_id", name: "sys_c0069616"

  add_foreign_key "preparation", "type_of_preparation", column: "type_id", name: "sys_c0069648"

  add_foreign_key "preparation_orders", "orders", name: "sys_c0069653"
  add_foreign_key "preparation_orders", "preparation", name: "sys_c0069652"

  add_foreign_key "telephone_numbers", "person", name: "sys_c0069623"

end
