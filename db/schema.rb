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

ActiveRecord::Schema.define(version: 20130920152948) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "formats", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "formats", ["name"], name: "index_formats_on_name", using: :btree

  create_table "movies", force: true do |t|
    t.string   "title"
    t.string   "title_index"
    t.string   "director"
    t.integer  "year"
    t.integer  "current_rating"
    t.integer  "skandies_year"
    t.boolean  "short",          default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "movies", ["skandies_year", "current_rating"], name: "index_movies_on_skandies_year_and_current_rating", using: :btree
  add_index "movies", ["skandies_year", "title_index"], name: "index_movies_on_skandies_year_and_title_index", using: :btree
  add_index "movies", ["title_index"], name: "index_movies_on_title_index", using: :btree
  add_index "movies", ["year", "current_rating"], name: "index_movies_on_year_and_current_rating", using: :btree

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.string   "remember_token"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["remember_token"], name: "index_users_on_remember_token", using: :btree

  create_table "viewings", force: true do |t|
    t.integer  "movie_id"
    t.datetime "date"
    t.integer  "format_id"
    t.string   "rating"
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "viewings", ["date"], name: "index_viewings_on_date", using: :btree

end
