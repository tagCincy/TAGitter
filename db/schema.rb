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

ActiveRecord::Schema.define(version: 20160502154158) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"

  create_table "favorited_posts", force: :cascade do |t|
    t.uuid     "post_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["post_id"], name: "index_favorited_posts_on_post_id", using: :btree
    t.index ["user_id"], name: "index_favorited_posts_on_user_id", using: :btree
  end

  create_table "posts", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.text     "body"
    t.integer  "user_id"
    t.uuid     "repost_id"
    t.integer  "reposted_count",  default: 0
    t.boolean  "deleted",         default: false
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.integer  "favorited_count", default: 0
    t.index ["repost_id"], name: "index_posts_on_repost_id", using: :btree
    t.index ["user_id"], name: "index_posts_on_user_id", using: :btree
  end

  create_table "profiles", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "name"
    t.text     "bio"
    t.string   "location"
    t.date     "dob"
    t.boolean  "protected"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_profiles_on_user_id", using: :btree
  end

  create_table "user_follows", force: :cascade do |t|
    t.integer  "follow_id"
    t.integer  "follower_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["follow_id"], name: "index_user_follows_on_follow_id", using: :btree
    t.index ["follower_id"], name: "index_user_follows_on_follower_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "handle",                 default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.integer  "follow_count",           default: 0
    t.integer  "follower_count",         default: 0
    t.integer  "posts_count",            default: 0
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  add_foreign_key "favorited_posts", "posts", on_delete: :cascade
  add_foreign_key "favorited_posts", "users", on_delete: :cascade
  add_foreign_key "posts", "posts", column: "repost_id", on_delete: :cascade
  add_foreign_key "posts", "users", on_delete: :cascade
  add_foreign_key "profiles", "users", on_delete: :cascade
  add_foreign_key "user_follows", "users", column: "follow_id", on_delete: :cascade
  add_foreign_key "user_follows", "users", column: "follower_id", on_delete: :cascade
end
