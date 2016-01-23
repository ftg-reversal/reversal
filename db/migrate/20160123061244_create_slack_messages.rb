class CreateSlackMessages < ActiveRecord::Migration
  def change
    create_table :slack_messages do |t|
      t.string :channel
      t.string :user
      t.string :type
      t.float :ts
      t.string :text

      t.timestamps null: false
    end

    add_index "slack_messages", ["channel"], name: "channel", unique: false, using: :btree
    add_index "slack_messages", ["user"], name: "user", unique: false, using: :btree
    add_index "slack_messages", ["ts"], name: "ts", unique: false, using: :btree
    add_index "slack_messages", ["channel", "user", "ts"], name: "channel_user_ts_index", unique: true, using: :btree
  end
end
