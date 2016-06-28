class RemoveReference < ActiveRecord::Migration
  def change
    remove_foreign_key "entries", "events"
    remove_foreign_key "entries", "reversal_users"
    remove_foreign_key "entry_players", "charas"
    remove_foreign_key "entry_players", "entries"
    remove_foreign_key "entry_players", "ranks"
    remove_foreign_key "events", "reversal_users"
    remove_foreign_key "reversal_users", "slack_users"
    remove_foreign_key "rlogs", "slack_channels"
    remove_foreign_key "slack_messages", "slack_channels"
    remove_foreign_key "slack_messages", "slack_users"
    remove_foreign_key "slack_messages_summaries", column: "summary_id"
    remove_foreign_key "slack_messages_summaries", "slack_messages"
    remove_foreign_key "twitter2slack_conditions", "slack_channels"
    remove_foreign_key "video_matchups", column: "chara1_id"
    remove_foreign_key "video_matchups", column: "chara2_id"
    remove_foreign_key "video_matchups", "videos"
  end
end
