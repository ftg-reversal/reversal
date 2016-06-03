class AddQuoteToTwitter2slackCondition < ActiveRecord::Migration
  def change
    add_column :twitter2slack_conditions, :quote, :boolean, default: false
  end
end
