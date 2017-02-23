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

ActiveRecord::Schema.define(version: 20170223193654) do

  create_table "account_identities", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.integer  "account_id", null: false
    t.string   "provider",   null: false
    t.string   "uid",        null: false
    t.string   "email",      null: false
    t.string   "nickname",   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["account_id"], name: "fk_rails_9db612c3dc", using: :btree
    t.index ["provider", "uid", "email"], name: "index_account_identities_on_provider_and_uid_and_email", unique: true, using: :btree
    t.index ["provider", "uid", "nickname"], name: "index_account_identities_on_provider_and_uid_and_nickname", unique: true, using: :btree
  end

  create_table "account_images", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.integer  "account_id",                 null: false
    t.binary   "data",         limit: 65535
    t.string   "content_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["account_id"], name: "index_account_images_on_account_id", using: :btree
  end

  create_table "accounts", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.string   "identify_name",                                   null: false
    t.string   "email",                                           null: false
    t.string   "email_for_index",                                 null: false
    t.boolean  "email_publication",               default: false, null: false
    t.string   "password_digest",                                 null: false
    t.text     "self_introduction", limit: 65535
    t.string   "sites"
    t.string   "company"
    t.string   "residence"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "account_token",     limit: 20,    default: "",    null: false
    t.index ["account_token"], name: "index_accounts_on_account_token", unique: true, using: :btree
    t.index ["identify_name", "email_for_index"], name: "index_accounts_on_identify_name_and_email_for_index", unique: true, using: :btree
  end

  create_table "administrators", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.string   "login_name",      null: false
    t.string   "password_digest", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "articles", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.integer  "account_id",                                null: false
    t.string   "title",                                     null: false
    t.text     "body",         limit: 65535,                null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "access_token", limit: 8,     default: "",   null: false
    t.boolean  "published",                  default: true, null: false
    t.index ["access_token"], name: "index_articles_on_access_token", unique: true, using: :btree
    t.index ["account_id"], name: "index_articles_on_account_id", using: :btree
  end

  create_table "bug_reports", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.string   "title",                       null: false
    t.string   "body",                        null: false
    t.boolean  "completable", default: false, null: false
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "comments", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.integer  "article_id",               null: false
    t.string   "name"
    t.text     "body",       limit: 65535, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["article_id"], name: "index_comments_on_article_id", using: :btree
  end

  create_table "stacks", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.integer  "account_id", null: false
    t.integer  "article_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["account_id", "article_id"], name: "index_stacks_on_account_id_and_article_id", unique: true, using: :btree
    t.index ["article_id"], name: "fk_rails_83b9af7949", using: :btree
  end

  create_table "taggings", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       limit: 128
    t.datetime "created_at"
    t.index ["context"], name: "index_taggings_on_context", using: :btree
    t.index ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true, using: :btree
    t.index ["tag_id"], name: "index_taggings_on_tag_id", using: :btree
    t.index ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context", using: :btree
    t.index ["taggable_id", "taggable_type", "tagger_id", "context"], name: "taggings_idy", using: :btree
    t.index ["taggable_id"], name: "index_taggings_on_taggable_id", using: :btree
    t.index ["taggable_type"], name: "index_taggings_on_taggable_type", using: :btree
    t.index ["tagger_id", "tagger_type"], name: "index_taggings_on_tagger_id_and_tagger_type", using: :btree
    t.index ["tagger_id"], name: "index_taggings_on_tagger_id", using: :btree
  end

  create_table "tags", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.string  "name",                       collation: "utf8_bin"
    t.integer "taggings_count", default: 0
    t.index ["name"], name: "index_tags_on_name", unique: true, using: :btree
  end

  add_foreign_key "account_identities", "accounts"
  add_foreign_key "account_images", "accounts"
  add_foreign_key "comments", "articles"
  add_foreign_key "stacks", "accounts"
  add_foreign_key "stacks", "articles"
end
