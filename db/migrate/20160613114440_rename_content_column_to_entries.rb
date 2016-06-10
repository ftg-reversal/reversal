class RenameContentColumnToEntries < ActiveRecord::Migration
  def change
    rename_column :entries, :content, :players
  end
end
