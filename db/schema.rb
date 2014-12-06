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

ActiveRecord::Schema.define(version: 20141206212240) do

  create_table "account_identities", force: true do |t|
    t.integer  "account_id", null: false
    t.string   "provider",   null: false
    t.string   "uid",        null: false
    t.string   "email",      null: false
    t.string   "nickname",   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "account_identities", ["account_id"], name: "account_identities_account_id_fk", using: :btree
  add_index "account_identities", ["provider", "uid", "email"], name: "index_account_identities_on_provider_and_uid_and_email", unique: true, using: :btree
  add_index "account_identities", ["provider", "uid", "nickname"], name: "index_account_identities_on_provider_and_uid_and_nickname", unique: true, using: :btree

  create_table "account_images", force: true do |t|
    t.integer  "account_id",   null: false
    t.binary   "data"
    t.string   "content_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "account_images", ["account_id"], name: "index_account_images_on_account_id", using: :btree

  create_table "accounts", force: true do |t|
    t.string   "identify_name",                                null: false
    t.string   "email",                                        null: false
    t.string   "email_for_index",                              null: false
    t.boolean  "email_publication",            default: false, null: false
    t.string   "password_digest",                              null: false
    t.text     "self_introduction"
    t.string   "sites"
    t.string   "company"
    t.string   "residence"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "account_token",     limit: 20, default: "",    null: false
  end

  add_index "accounts", ["account_token"], name: "index_accounts_on_account_token", unique: true, using: :btree
  add_index "accounts", ["identify_name", "email_for_index"], name: "index_accounts_on_identify_name_and_email_for_index", unique: true, using: :btree

  create_table "administrators", force: true do |t|
    t.string   "login_name",      null: false
    t.string   "password_digest", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "articles", force: true do |t|
    t.integer  "account_id",                          null: false
    t.string   "title",                               null: false
    t.text     "body",                                null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "access_token", limit: 8, default: "", null: false
  end

  add_index "articles", ["access_token"], name: "index_articles_on_access_token", unique: true, using: :btree
  add_index "articles", ["account_id"], name: "index_articles_on_account_id", using: :btree

  create_table "comments", force: true do |t|
    t.integer  "article_id", null: false
    t.string   "name"
    t.text     "body",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["article_id"], name: "index_comments_on_article_id", using: :btree

  create_table "stacks", force: true do |t|
    t.integer  "account_id", null: false
    t.integer  "article_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "stacks", ["account_id", "article_id"], name: "index_stacks_on_account_id_and_article_id", unique: true, using: :btree
  add_index "stacks", ["article_id"], name: "stacks_article_id_fk", using: :btree

  create_table "taggings", force: true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       limit: 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true, using: :btree
  add_index "taggings", ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context", using: :btree

  create_table "tags", force: true do |t|
    t.string  "name"
    t.integer "taggings_count", default: 0
  end

  add_index "tags", ["name"], name: "index_tags_on_name", unique: true, using: :btree

  add_foreign_key "account_identities", "accounts", name: "account_identities_account_id_fk"

  add_foreign_key "account_images", "accounts", name: "account_images_account_id_fk"

  add_foreign_key "comments", "articles", name: "comments_article_id_fk"

  add_foreign_key "stacks", "accounts", name: "stacks_account_id_fk"
  add_foreign_key "stacks", "articles", name: "stacks_article_id_fk"

end
