class AddForeignKeys < ActiveRecord::Migration
  def change
    change_column "reversal_users", "slack_user_id", :integer
    add_foreign_key "entries", "events"
    add_foreign_key "entries", "reversal_users"
    add_foreign_key "entries", "twitter_users"
    add_foreign_key "events", "reversal_users"
    add_foreign_key "reversal_users", "slack_users"
    add_foreign_key "slack_messages", "slack_channels"
    add_foreign_key "slack_messages", "slack_users"
  end
end
