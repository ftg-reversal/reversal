class CreateRlog < ActiveRecord::Migration
  def change
    create_table :rlogs do |t|
      t.string :title, null: false
      t.text :description
      t.integer :slack_channel_id
      t.integer :reversal_user_id, null: false
      t.string :type, null: false
      t.datetime :created_at
      t.datetime :updated_at
    end

    add_index :rlogs, :type
    add_index :rlogs, :reversal_user_id
    add_foreign_key :rlogs, :slack_channels
  end
end
