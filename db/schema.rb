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

ActiveRecord::Schema.define(version: 20150603222206) do

  create_table "comments", force: :cascade do |t|
    t.integer  "user_id",     limit: 4
    t.integer  "location_id", limit: 4
    t.text     "content",     limit: 65535,             null: false
    t.integer  "rate",        limit: 4,                 null: false
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.integer  "upvote",      limit: 4,     default: 0
    t.integer  "downvote",    limit: 4,     default: 0
  end

  add_index "comments", ["location_id"], name: "index_comments_on_location_id", using: :btree
  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree

  create_table "likes", force: :cascade do |t|
    t.integer  "user_id",     limit: 4, null: false
    t.integer  "location_id", limit: 4, null: false
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  add_index "likes", ["location_id"], name: "index_likes_on_location_id", using: :btree
  add_index "likes", ["user_id"], name: "index_likes_on_user_id", using: :btree

  create_table "locations", force: :cascade do |t|
    t.string   "name",       limit: 255,                                   null: false
    t.string   "address",    limit: 255,                                   null: false
    t.string   "img_url",    limit: 255,   default: ""
    t.text     "intro",      limit: 65535
    t.string   "avg_price",  limit: 255
    t.time     "start_time",               default: '2000-01-01 00:00:00'
    t.time     "end_time",                 default: '2000-01-01 00:00:00'
    t.float    "latitude",   limit: 24,    default: 0.0
    t.float    "longitude",  limit: 24,    default: 0.0
    t.datetime "created_at",                                               null: false
    t.datetime "updated_at",                                               null: false
    t.string   "rate",       limit: 255
  end

  add_index "locations", ["name"], name: "index_locations_on_name", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "name",              limit: 255
    t.string   "email",             limit: 255
    t.datetime "created_at",                                    null: false
    t.datetime "updated_at",                                    null: false
    t.string   "password_digest",   limit: 255
    t.string   "remember_digest",   limit: 255
    t.boolean  "admin",             limit: 1
    t.string   "activation_digest", limit: 255
    t.boolean  "activated",         limit: 1,   default: false
    t.datetime "activated_at"
    t.string   "reset_digest",      limit: 255
    t.datetime "reset_sent_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree

  create_table "votes", force: :cascade do |t|
    t.integer  "comment_id", limit: 4,             null: false
    t.integer  "user_id",    limit: 4,             null: false
    t.integer  "upvote",     limit: 4, default: 0
    t.integer  "downvote",   limit: 4, default: 0
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
  end

  add_index "votes", ["comment_id"], name: "index_votes_on_comment_id", using: :btree
  add_index "votes", ["user_id"], name: "index_votes_on_user_id", using: :btree

end
