class CreateEntries < ActiveRecord::Migration
  def change
    create_table :entries do |t|
      t.string :name
      t.references :chara
      t.references :rank
      t.text :comment
      t.references :event
      t.references :reversal_user
      t.references :twitter_user

      t.timestamps null: false
    end
  end
end
