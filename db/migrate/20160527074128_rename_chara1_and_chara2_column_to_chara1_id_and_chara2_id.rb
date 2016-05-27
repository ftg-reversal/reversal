class RenameChara1AndChara2ColumnToChara1IdAndChara2Id < ActiveRecord::Migration
  def change
    rename_column :video_matchups, :chara1, :chara1_id
    rename_column :video_matchups, :chara2, :chara2_id
  end
end
