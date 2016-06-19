class DropPageAndSummary < ActiveRecord::Migration
  def change
    remove_reference :summaries, :reversal_user, index: true, foreign_key: true
    remove_reference :summaries, :slack_channel, index: true, foreign_key: true
    remove_reference :slack_messages_summaries, :summary, index: true, foreign_key: true
    drop_table :pages
    drop_table :summaries

    add_column :slack_messages_summaries, :summary_id, :integer
    add_foreign_key :slack_messages_summaries, :rlogs, column: :summary_id
  end
end
