class CreateReversalUsers < ActiveRecord::Migration
  def change
    create_table :reversal_users do |t|
      t.string :slack_user_id
      t.boolean :is_admin

      t.timestamps null: false
    end

    add_index "reversal_users", ["slack_user_id"], name: "slack_user_id", unique: true, using: :btree
  end
end
