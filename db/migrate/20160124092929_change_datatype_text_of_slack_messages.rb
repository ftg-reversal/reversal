class ChangeDatatypeTextOfSlackMessages < ActiveRecord::Migration
  def change
    change_column :slack_messages, :text, :text
  end
end
