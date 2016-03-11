class AddSlackChannelIdToSummaries < ActiveRecord::Migration
  def change
    add_reference :summaries, :slack_channel, index: true, foreign_key: true, null: false
  end
end
