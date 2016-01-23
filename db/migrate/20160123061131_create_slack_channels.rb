class CreateSlackChannels < ActiveRecord::Migration
  def change
    create_table :slack_channels do |t|
      t.string :cid
      t.string :name
      t.string :topic
      t.boolean :is_archived

      t.timestamps null: false
    end

    add_index "slack_channels", ["cid"], name: "cid", unique: true, using: :btree
  end
end
