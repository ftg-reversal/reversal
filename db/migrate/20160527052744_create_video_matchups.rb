class CreateVideoMatchups < ActiveRecord::Migration
  def change
    create_table :video_matchups do |t|
      t.integer :video_id
      t.integer :chara1
      t.integer :chara2
      t.integer :sec
    end

    add_foreign_key 'video_matchups', 'videos'
    add_foreign_key 'video_matchups', 'charas', column: 'chara1'
    add_foreign_key 'video_matchups', 'charas', column: 'chara2'
  end
end
