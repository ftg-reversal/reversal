class ChangeDatatypeSlackMessageOfIcon < ActiveRecord::Migration
  def change
    change_column :slack_messages, :icon, :text
  end
end
