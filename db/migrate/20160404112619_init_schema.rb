class InitSchema < ActiveRecord::Migration
  def up

    create_table "charas", force: :cascade do |t|
      t.string   "name",       limit: 255
      t.datetime "created_at",             null: false
      t.datetime "updated_at",             null: false
    end

    create_table "ckeditor_assets", force: :cascade do |t|
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

    create_table "entries", force: :cascade do |t|
      t.string   "name",             limit: 255
      t.integer  "chara_id",         limit: 4
      t.integer  "rank_id",          limit: 4
      t.text     "comment",          limit: 65535
      t.integer  "event_id",         limit: 4
      t.integer  "reversal_user_id", limit: 4
      t.integer  "twitter_user_id",  limit: 4
      t.datetime "created_at",                     null: false
      t.datetime "updated_at",                     null: false
    end

    create_table "events", force: :cascade do |t|
      t.string   "title",            limit: 255
      t.text     "description",      limit: 65535
      t.datetime "datetime"
      t.integer  "reversal_user_id", limit: 4
      t.datetime "created_at",                     null: false
      t.datetime "updated_at",                     null: false
    end

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

    create_table "pages", force: :cascade do |t|
      t.string   "title",            limit: 255,   null: false
      t.text     "description",      limit: 65535, null: false
      t.integer  "reversal_user_id", limit: 4,     null: false
      t.datetime "created_at",                     null: false
      t.datetime "updated_at",                     null: false
    end

    add_index "pages", ["reversal_user_id"], name: "index_pages_on_reversal_user_id", using: :btree

    create_table "ranks", force: :cascade do |t|
      t.string   "rank",       limit: 255
      t.datetime "created_at",             null: false
      t.datetime "updated_at",             null: false
    end

    create_table "reversal_users", force: :cascade do |t|
      t.string   "slack_user_id", limit: 255
      t.boolean  "is_admin"
      t.datetime "created_at",                null: false
      t.datetime "updated_at",                null: false
    end

    add_index "reversal_users", ["slack_user_id"], name: "slack_user_id", unique: true, using: :btree

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

    create_table "slack_messages_summaries", force: :cascade do |t|
      t.integer "slack_message_id", limit: 4, null: false
      t.integer "summary_id",       limit: 4, null: false
    end

    add_index "slack_messages_summaries", ["slack_message_id"], name: "index_slack_messages_summaries_on_slack_message_id", using: :btree
    add_index "slack_messages_summaries", ["summary_id"], name: "index_slack_messages_summaries_on_summary_id", using: :btree

    create_table "slack_users", force: :cascade do |t|
      t.string   "uid",        limit: 255
      t.string   "name",       limit: 255
      t.string   "icon_url",   limit: 255
      t.datetime "created_at",             null: false
      t.datetime "updated_at",             null: false
    end

    add_index "slack_users", ["uid"], name: "uid", unique: true, using: :btree

    create_table "summaries", force: :cascade do |t|
      t.string   "title",            limit: 255,   null: false
      t.text     "description",      limit: 65535, null: false
      t.integer  "reversal_user_id", limit: 4,     null: false
      t.datetime "created_at",                     null: false
      t.datetime "updated_at",                     null: false
      t.integer  "slack_channel_id", limit: 4,     null: false
    end

    add_index "summaries", ["reversal_user_id"], name: "index_summaries_on_reversal_user_id", using: :btree
    add_index "summaries", ["slack_channel_id"], name: "index_summaries_on_slack_channel_id", using: :btree

    create_table "twitter_users", force: :cascade do |t|
      t.string   "uid",         limit: 255
      t.string   "screen_name", limit: 255
      t.string   "name",        limit: 255
      t.string   "icon_url",    limit: 255
      t.datetime "created_at",              null: false
      t.datetime "updated_at",              null: false
    end

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

    add_foreign_key "pages", "reversal_users"
    add_foreign_key "slack_messages_summaries", "slack_messages"
    add_foreign_key "slack_messages_summaries", "summaries"
    add_foreign_key "summaries", "reversal_users"
    add_foreign_key "summaries", "slack_channels"
  end

  def down
    raise "Can not revert initial migration"
  end
end