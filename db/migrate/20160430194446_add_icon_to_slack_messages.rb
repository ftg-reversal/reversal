class AddIconToSlackMessages < ActiveRecord::Migration
  def change
    add_column :slack_messages, :icon, :string
  end
end
