class CreateEntryPlayers < ActiveRecord::Migration
  def change
    create_table :entry_players do |t|
      t.string :name
      t.integer :chara_id
      t.integer :rank_id
    end

    add_foreign_key :entry_players, :charas
    add_foreign_key :entry_players, :ranks
  end
end
