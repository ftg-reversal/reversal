class CreateSlackMessages < ActiveRecord::Migration
  def change
    create_table :slack_messages do |t|
      t.integer :slack_channel_id
      t.integer :slack_user_id
      t.decimal :ts, precision: 16, scale: 6
      t.string :text

      t.timestamps null: false
    end

    add_index "slack_messages", ["slack_channel_id"], name: "slack_channel_id", unique: false, using: :btree
    add_index "slack_messages", ["slack_user_id"], name: "slack_user_id", unique: false, using: :btree
    add_index "slack_messages", ["ts"], name: "ts", unique: false, using: :btree
    add_index "slack_messages", ["slack_channel_id", "ts"], name: "channel_ts_index", unique: false, using: :btree
    add_index "slack_messages", ["slack_channel_id", "slack_user_id", "ts"], name: "channel_user_ts_index", unique: true, using: :btree
  end
end
