class RenameColumnToReversalUser < ActiveRecord::Migration
  def change
    rename_column :reversal_users, :rank, :rank_id
    rename_column :reversal_users, :use_chara, :chara_id
  end
end
