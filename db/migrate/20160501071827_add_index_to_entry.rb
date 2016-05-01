class AddIndexToEntry < ActiveRecord::Migration
  def change
    add_index :entries, :chara_id
    add_index :entries, :rank_id

    add_index :lives, :live_id
    add_index :videos, :video_id
  end
end
