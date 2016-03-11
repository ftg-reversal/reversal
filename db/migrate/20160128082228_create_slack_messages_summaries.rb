class CreateSlackMessagesSummaries < ActiveRecord::Migration
  def change
    create_table :slack_messages_summaries do |t|
      t.references :slack_message, index: true, foreign_key: true, null: false
      t.references :summary, index: true, foreign_key: true, null: false
    end
  end
end
