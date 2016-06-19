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

ActiveRecord::Schema.define(version: 20160619195234) do

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
    t.integer  "event_id",         limit: 4
    t.integer  "reversal_user_id", limit: 4
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  add_index "entries", ["event_id"], name: "fk_rails_20eb5df311", using: :btree
  add_index "entries", ["reversal_user_id"], name: "fk_rails_6a9722b611", using: :btree

  create_table "entry_players", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.string  "name",     limit: 255
    t.integer "chara_id", limit: 4
    t.integer "rank_id",  limit: 4
    t.integer "entry_id", limit: 4
  end

  add_index "entry_players", ["chara_id"], name: "fk_rails_53cb378c6b", using: :btree
  add_index "entry_players", ["entry_id"], name: "fk_rails_c0b8648e8b", using: :btree
  add_index "entry_players", ["rank_id"], name: "fk_rails_001d489769", using: :btree

  create_table "events", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.string   "title",            limit: 255
    t.text     "description",      limit: 65535
    t.datetime "datetime"
    t.integer  "reversal_user_id", limit: 4
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
    t.datetime "entry_deadline"
    t.integer  "number",           limit: 4,     default: 1, null: false
  end

  add_index "events", ["reversal_user_id"], name: "fk_rails_337cdb79bb", using: :btree

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
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.integer  "twitter_user_id", limit: 4
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
  add_index "rlogs", ["slack_channel_id"], name: "fk_rails_9daab45809", using: :btree
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
    t.integer  "slack_channel_id", limit: 4
    t.integer  "slack_user_id",    limit: 4
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
    t.integer "summary_id",       limit: 4
  end

  add_index "slack_messages_summaries", ["slack_message_id"], name: "index_slack_messages_summaries_on_slack_message_id", using: :btree
  add_index "slack_messages_summaries", ["summary_id"], name: "fk_rails_2a1b919d51", using: :btree

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

  add_index "twitter2slack_conditions", ["slack_channel_id"], name: "fk_rails_64fa99355b", using: :btree

  create_table "twitter_users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.string   "uid",         limit: 255
    t.string   "screen_name", limit: 255
    t.string   "name",        limit: 255
    t.string   "icon_url",    limit: 255
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "video_matchups", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.integer "video_id",  limit: 4
    t.integer "chara1_id", limit: 4
    t.integer "chara2_id", limit: 4
    t.integer "sec",       limit: 4
  end

  add_index "video_matchups", ["chara1_id"], name: "fk_rails_238a2e45c9", using: :btree
  add_index "video_matchups", ["chara2_id"], name: "fk_rails_689c62c943", using: :btree
  add_index "video_matchups", ["video_id"], name: "fk_rails_b3ee212891", using: :btree

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

  add_foreign_key "entries", "events"
  add_foreign_key "entries", "reversal_users"
  add_foreign_key "entry_players", "charas"
  add_foreign_key "entry_players", "entries"
  add_foreign_key "entry_players", "ranks"
  add_foreign_key "events", "reversal_users"
  add_foreign_key "reversal_users", "slack_users"
  add_foreign_key "rlogs", "slack_channels"
  add_foreign_key "slack_messages", "slack_channels"
  add_foreign_key "slack_messages", "slack_users"
  add_foreign_key "slack_messages_summaries", "rlogs", column: "summary_id"
  add_foreign_key "slack_messages_summaries", "slack_messages"
  add_foreign_key "twitter2slack_conditions", "slack_channels"
  add_foreign_key "video_matchups", "charas", column: "chara1_id"
  add_foreign_key "video_matchups", "charas", column: "chara2_id"
  add_foreign_key "video_matchups", "videos"
end
