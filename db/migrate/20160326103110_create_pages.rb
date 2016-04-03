class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.string :title, null: false
      t.text :description, null: false
      t.belongs_to :reversal_user, index: true, foreign_key: true, null: false

      t.timestamps null: false
    end
  end
end
