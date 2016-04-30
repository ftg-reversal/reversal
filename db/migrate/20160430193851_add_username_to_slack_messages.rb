class AddUsernameToSlackMessages < ActiveRecord::Migration
  def change
    add_column :slack_messages, :username, :string
  end
end
