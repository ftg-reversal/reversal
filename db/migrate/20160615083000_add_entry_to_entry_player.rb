class AddEntryToEntryPlayer < ActiveRecord::Migration
  def change
    add_column :entry_players, :entry_id, :integer, nil: false
    add_foreign_key :entry_players, :entries
  end
end
