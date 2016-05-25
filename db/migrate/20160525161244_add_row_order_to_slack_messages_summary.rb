class AddRowOrderToSlackMessagesSummary < ActiveRecord::Migration
  def change
    add_column :slack_messages_summaries, :row_order, :integer
  end
end
