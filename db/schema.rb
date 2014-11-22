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

ActiveRecord::Schema.define(version: 20141110143535) do

  create_table "accounts", force: true do |t|
    t.string   "identify_name",                     null: false
    t.string   "email",                             null: false
    t.string   "email_for_index",                   null: false
    t.boolean  "email_publication", default: false, null: false
    t.string   "password_digest",                   null: false
    t.text     "self_introduction",                 null: false
    t.string   "sites"
    t.string   "company"
    t.string   "residence"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "accounts", ["identify_name", "email_for_index"], name: "index_accounts_on_identify_name_and_email_for_index", unique: true, using: :btree

  create_table "administrators", force: true do |t|
    t.string   "login_name",      null: false
    t.string   "password_digest", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "articles", force: true do |t|
    t.integer  "account_id", null: false
    t.string   "title",      null: false
    t.text     "body",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "articles", ["account_id"], name: "index_articles_on_account_id", using: :btree

  create_table "comments", force: true do |t|
    t.integer  "article_id", null: false
    t.string   "name"
    t.text     "body",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["article_id"], name: "index_comments_on_article_id", using: :btree

end
