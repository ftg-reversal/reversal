class AddFileToSlackMessages < ActiveRecord::Migration
  def change
    add_column :slack_messages, :file, :text
  end
end
