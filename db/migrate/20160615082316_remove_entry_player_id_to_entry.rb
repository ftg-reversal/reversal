class RemoveEntryPlayerIdToEntry < ActiveRecord::Migration
  def change
    remove_reference :entries, :entry_player, index: true, foreign_key: true
  end
end
