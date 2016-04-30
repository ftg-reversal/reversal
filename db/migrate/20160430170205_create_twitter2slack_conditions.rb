class CreateTwitter2slackConditions < ActiveRecord::Migration
  def change
    create_table :twitter2slack_conditions do |t|
      t.string 'text', null: false
      t.integer 'slack_channel_id', null: false
      t.integer 'last_tweet', limit: 8, null: false, default: 0
      t.timestamps null: false
    end

    add_foreign_key 'twitter2slack_conditions', 'slack_channels'
  end
end
