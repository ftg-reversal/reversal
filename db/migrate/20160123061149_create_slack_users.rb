class CreateSlackUsers < ActiveRecord::Migration
  def change
    create_table :slack_users do |t|
      t.string :uid
      t.string :name

      t.timestamps null: false
    end

    add_index "slack_users", ["uid"], name: "uid", unique: true, using: :btree
  end
end
