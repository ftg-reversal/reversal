class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :title
      t.text :description
      t.datetime :datetime
      t.integer :reversal_user_id

      t.timestamps null: false
    end
  end
end
