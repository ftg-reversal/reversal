class RemoveNemeCharaAndRankToEntry < ActiveRecord::Migration
  def change
    remove_column :entries, :name
    remove_column :entries, :chara_id
    remove_column :entries, :rank_id
  end
end
