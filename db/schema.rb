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

ActiveRecord::Schema.define(version: 20160124114550) do

  create_table "lives", force: :cascade do |t|
    t.string   "live_id",           limit: 255
    t.string   "url",               limit: 255
    t.string   "title",             limit: 255
    t.datetime "start_time"
    t.string   "icon_url",          limit: 255
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.string   "icon_file_name",    limit: 255
    t.string   "icon_content_type", limit: 255
    t.integer  "icon_file_size",    limit: 4
    t.datetime "icon_updated_at"
  end

  create_table "slack_channels", force: :cascade do |t|
    t.string   "cid",         limit: 255
    t.string   "name",        limit: 255
    t.string   "topic",       limit: 255
    t.boolean  "is_archived"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "slack_channels", ["cid"], name: "cid", unique: true, using: :btree

  create_table "slack_messages", force: :cascade do |t|
    t.integer  "slack_channel_id", limit: 4
    t.integer  "slack_user_id",    limit: 4
    t.decimal  "ts",                             precision: 16, scale: 6
    t.text     "text",             limit: 65535
    t.datetime "created_at",                                              null: false
    t.datetime "updated_at",                                              null: false
    t.text     "attachments",      limit: 65535
    t.text     "file",             limit: 65535
  end

  add_index "slack_messages", ["slack_channel_id", "slack_user_id", "ts"], name: "channel_user_ts_index", unique: true, using: :btree
  add_index "slack_messages", ["slack_channel_id", "ts"], name: "channel_ts_index", using: :btree
  add_index "slack_messages", ["slack_channel_id"], name: "slack_channel_id", using: :btree
  add_index "slack_messages", ["slack_user_id"], name: "slack_user_id", using: :btree
  add_index "slack_messages", ["ts"], name: "ts", using: :btree

  create_table "slack_users", force: :cascade do |t|
    t.string   "uid",        limit: 255
    t.string   "name",       limit: 255
    t.string   "icon_url",   limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "slack_users", ["uid"], name: "uid", unique: true, using: :btree

  create_table "video_site_search_conditions", force: :cascade do |t|
    t.string   "word",       limit: 255, default: "", null: false
    t.string   "video_site", limit: 255, default: "", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "videos", force: :cascade do |t|
    t.string   "url",                    limit: 255, default: "", null: false
    t.string   "video_id",               limit: 255
    t.string   "video_site",             limit: 255,              null: false
    t.string   "title",                  limit: 255, default: "", null: false
    t.datetime "posted_at",                                       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "thumbnail_file_name",    limit: 255
    t.string   "thumbnail_content_type", limit: 255
    t.integer  "thumbnail_file_size",    limit: 4
    t.datetime "thumbnail_updated_at"
  end

  add_index "videos", ["url"], name: "url", unique: true, using: :btree

end
