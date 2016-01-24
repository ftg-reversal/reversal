class AddAttachmentsToSlackMessages < ActiveRecord::Migration
  def change
    add_column :slack_messages, :attachments, :text
  end
end
