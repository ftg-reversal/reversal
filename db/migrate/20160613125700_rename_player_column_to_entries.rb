class RenamePlayerColumnToEntries < ActiveRecord::Migration
  def change
    change_column :entries, :players, :integer
    rename_column :entries, :players, :entry_player_id
    add_foreign_key :entries, :entry_players
  end
end
