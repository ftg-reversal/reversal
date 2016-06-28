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

ActiveRecord::Schema.define(version: 20160628160146) do

  create_table "charas", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.string   "en_name",    limit: 255
  end

  create_table "ckeditor_assets", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.string   "data_file_name",    limit: 255, null: false
    t.string   "data_content_type", limit: 255
    t.integer  "data_file_size",    limit: 4
    t.integer  "assetable_id",      limit: 4
    t.string   "assetable_type",    limit: 30
    t.string   "type",              limit: 30
    t.integer  "width",             limit: 4
    t.integer  "height",            limit: 4
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  add_index "ckeditor_assets", ["assetable_type", "assetable_id"], name: "idx_ckeditor_assetable", using: :btree
  add_index "ckeditor_assets", ["assetable_type", "type", "assetable_id"], name: "idx_ckeditor_assetable_type", using: :btree

  create_table "entries", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.text     "comment",          limit: 65535
    t.integer  "event_id",         limit: 4,     null: false
    t.integer  "reversal_user_id", limit: 4,     null: false
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  add_index "entries", ["event_id"], name: "index_entries_on_event_id", using: :btree
  add_index "entries", ["reversal_user_id"], name: "index_entries_on_reversal_user_id", using: :btree

  create_table "entry_players", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.string  "name",     limit: 255
    t.integer "chara_id", limit: 4,   null: false
    t.integer "rank_id",  limit: 4,   null: false
    t.integer "entry_id", limit: 4,   null: false
  end

  add_index "entry_players", ["chara_id"], name: "index_entry_players_on_chara_id", using: :btree
  add_index "entry_players", ["entry_id"], name: "index_entry_players_on_entry_id", using: :btree
  add_index "entry_players", ["rank_id"], name: "index_entry_players_on_rank_id", using: :btree

  create_table "events", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.string   "title",            limit: 255
    t.text     "description",      limit: 65535
    t.datetime "datetime"
    t.integer  "reversal_user_id", limit: 4,                 null: false
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
    t.datetime "entry_deadline"
    t.integer  "number",           limit: 4,     default: 1, null: false
  end

  add_index "events", ["reversal_user_id"], name: "events_on_reversal_user_id", using: :btree

  create_table "lives", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
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

  add_index "lives", ["live_id"], name: "index_lives_on_live_id", using: :btree

  create_table "ranks", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.string   "rank",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "reversal_users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.integer  "slack_user_id",   limit: 4
    t.boolean  "is_admin"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.integer  "twitter_user_id", limit: 4
    t.integer  "chara_id",        limit: 4
    t.integer  "rank_id",         limit: 4
    t.text     "home",            limit: 65535
    t.text     "bio",             limit: 65535
    t.string   "name",            limit: 255
  end

  add_index "reversal_users", ["slack_user_id"], name: "slack_user_id", unique: true, using: :btree
  add_index "reversal_users", ["twitter_user_id"], name: "index_reversal_users_on_twitter_user_id", unique: true, using: :btree

  create_table "rlogs", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.string   "title",            limit: 255,   null: false
    t.text     "description",      limit: 65535
    t.integer  "slack_channel_id", limit: 4
    t.integer  "reversal_user_id", limit: 4,     null: false
    t.string   "type",             limit: 255,   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "rlogs", ["reversal_user_id"], name: "index_rlogs_on_reversal_user_id", using: :btree
  add_index "rlogs", ["slack_channel_id"], name: "index_rlogs_on_slack_channel_id", using: :btree
  add_index "rlogs", ["type"], name: "index_rlogs_on_type", using: :btree

  create_table "slack_channels", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.string   "cid",         limit: 255
    t.string   "name",        limit: 255
    t.string   "topic",       limit: 255
    t.boolean  "is_archived"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "slack_channels", ["cid"], name: "cid", unique: true, using: :btree

  create_table "slack_messages", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.integer  "slack_channel_id", limit: 4,                              null: false
    t.integer  "slack_user_id",    limit: 4,                              null: false
    t.decimal  "ts",                             precision: 16, scale: 6
    t.text     "text",             limit: 65535
    t.datetime "created_at",                                              null: false
    t.datetime "updated_at",                                              null: false
    t.text     "attachments",      limit: 65535
    t.text     "file",             limit: 65535
    t.string   "username",         limit: 255
    t.text     "icon",             limit: 65535
  end

  add_index "slack_messages", ["slack_channel_id", "slack_user_id", "ts"], name: "channel_user_ts_index", unique: true, using: :btree
  add_index "slack_messages", ["slack_channel_id", "ts"], name: "channel_ts_index", using: :btree
  add_index "slack_messages", ["slack_channel_id"], name: "slack_channel_id", using: :btree
  add_index "slack_messages", ["slack_user_id"], name: "slack_user_id", using: :btree
  add_index "slack_messages", ["ts"], name: "ts", using: :btree

  create_table "slack_messages_summaries", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.integer "slack_message_id", limit: 4, null: false
    t.integer "row_order",        limit: 4
    t.integer "summary_id",       limit: 4, null: false
  end

  add_index "slack_messages_summaries", ["slack_message_id"], name: "index_slack_messages_summaries_on_slack_message_id", using: :btree
  add_index "slack_messages_summaries", ["summary_id"], name: "index_slack_messages_summaries_on_summary_id", using: :btree

  create_table "slack_users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.string   "uid",        limit: 255
    t.string   "name",       limit: 255
    t.string   "icon_url",   limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "slack_users", ["uid"], name: "uid", unique: true, using: :btree

  create_table "twitter2slack_conditions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.string   "text",             limit: 255,                 null: false
    t.integer  "slack_channel_id", limit: 4,                   null: false
    t.integer  "last_tweet",       limit: 8,   default: 0,     null: false
    t.datetime "created_at",                                   null: false
    t.datetime "updated_at",                                   null: false
    t.boolean  "quote",                        default: false
  end

  add_index "twitter2slack_conditions", ["slack_channel_id"], name: "index_twitter2slack_conditions_on_slack_channel_id", using: :btree

  create_table "twitter_users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.string   "uid",         limit: 255
    t.string   "screen_name", limit: 255
    t.string   "name",        limit: 255
    t.string   "icon_url",    limit: 255
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "video_matchups", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.integer "video_id",  limit: 4, null: false
    t.integer "chara1_id", limit: 4, null: false
    t.integer "chara2_id", limit: 4, null: false
    t.integer "sec",       limit: 4
  end

  add_index "video_matchups", ["chara1_id"], name: "index_video_matchups_on_chara1_id", using: :btree
  add_index "video_matchups", ["chara2_id"], name: "index_video_matchups_on_chara2_id", using: :btree
  add_index "video_matchups", ["video_id"], name: "index_video_matchups_on_video_id", using: :btree

  create_table "video_site_search_conditions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.string   "word",       limit: 255, default: "", null: false
    t.string   "video_site", limit: 255, default: "", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "videos", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
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
  add_index "videos", ["video_id"], name: "index_videos_on_video_id", using: :btree

end
