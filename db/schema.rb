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

ActiveRecord::Schema.define(version: 20150104161317) do

  create_table "account_identities", force: :cascade do |t|
    t.integer  "account_id", limit: 4,   null: false
    t.string   "provider",   limit: 255, null: false
    t.string   "uid",        limit: 255, null: false
    t.string   "email",      limit: 255, null: false
    t.string   "nickname",   limit: 255, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "account_identities", ["account_id"], name: "fk_rails_273a77a371", using: :btree
  add_index "account_identities", ["provider", "uid", "email"], name: "index_account_identities_on_provider_and_uid_and_email", unique: true, using: :btree
  add_index "account_identities", ["provider", "uid", "nickname"], name: "index_account_identities_on_provider_and_uid_and_nickname", unique: true, using: :btree

  create_table "account_images", force: :cascade do |t|
    t.integer  "account_id",   limit: 4,     null: false
    t.binary   "data",         limit: 65535
    t.string   "content_type", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "account_images", ["account_id"], name: "index_account_images_on_account_id", using: :btree

  create_table "accounts", force: :cascade do |t|
    t.string   "identify_name",     limit: 255,                   null: false
    t.string   "email",             limit: 255,                   null: false
    t.string   "email_for_index",   limit: 255,                   null: false
    t.boolean  "email_publication", limit: 1,     default: false, null: false
    t.string   "password_digest",   limit: 255,                   null: false
    t.text     "self_introduction", limit: 65535
    t.string   "sites",             limit: 255
    t.string   "company",           limit: 255
    t.string   "residence",         limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "account_token",     limit: 20,    default: "",    null: false
  end

  add_index "accounts", ["account_token"], name: "index_accounts_on_account_token", unique: true, using: :btree
  add_index "accounts", ["identify_name", "email_for_index"], name: "index_accounts_on_identify_name_and_email_for_index", unique: true, using: :btree

  create_table "administrators", force: :cascade do |t|
    t.string   "login_name",      limit: 255, null: false
    t.string   "password_digest", limit: 255, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "articles", force: :cascade do |t|
    t.integer  "account_id",   limit: 4,                    null: false
    t.string   "title",        limit: 255,                  null: false
    t.text     "body",         limit: 65535,                null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "access_token", limit: 8,     default: "",   null: false
    t.boolean  "published",    limit: 1,     default: true, null: false
  end

  add_index "articles", ["access_token"], name: "index_articles_on_access_token", unique: true, using: :btree
  add_index "articles", ["account_id"], name: "index_articles_on_account_id", using: :btree

  create_table "bug_reports", force: :cascade do |t|
    t.string   "title",       limit: 255,                 null: false
    t.string   "body",        limit: 255,                 null: false
    t.boolean  "completable", limit: 1,   default: false, null: false
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
  end

  create_table "comments", force: :cascade do |t|
    t.integer  "article_id", limit: 4,     null: false
    t.string   "name",       limit: 255
    t.text     "body",       limit: 65535, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["article_id"], name: "index_comments_on_article_id", using: :btree

  create_table "stacks", force: :cascade do |t|
    t.integer  "account_id", limit: 4, null: false
    t.integer  "article_id", limit: 4, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "stacks", ["account_id", "article_id"], name: "index_stacks_on_account_id_and_article_id", unique: true, using: :btree
  add_index "stacks", ["article_id"], name: "fk_rails_2d5d7fc40c", using: :btree

  create_table "taggings", force: :cascade do |t|
    t.integer  "tag_id",        limit: 4
    t.integer  "taggable_id",   limit: 4
    t.string   "taggable_type", limit: 255
    t.integer  "tagger_id",     limit: 4
    t.string   "tagger_type",   limit: 255
    t.string   "context",       limit: 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true, using: :btree
  add_index "taggings", ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context", using: :btree

  create_table "tags", force: :cascade do |t|
    t.string  "name",           limit: 255
    t.integer "taggings_count", limit: 4,   default: 0
  end

  add_index "tags", ["name"], name: "index_tags_on_name", unique: true, using: :btree

  add_foreign_key "account_identities", "accounts"
  add_foreign_key "account_images", "accounts"
  add_foreign_key "comments", "articles"
  add_foreign_key "stacks", "accounts"
  add_foreign_key "stacks", "articles"
end
