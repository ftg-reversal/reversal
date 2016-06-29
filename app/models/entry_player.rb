# == Schema Information
#
# Table name: entry_players
#
#  id       :integer          not null, primary key
#  name     :string(255)
#  entry_id :integer          not null
#  chara_id :integer          not null
#  rank_id  :integer          not null
#
# Indexes
#
#  index_entry_players_on_chara_id  (chara_id)
#  index_entry_players_on_entry_id  (entry_id)
#  index_entry_players_on_rank_id   (rank_id)
#

class EntryPlayer < ActiveRecord::Base
  belongs_to :entry
  belongs_to :chara
  belongs_to :rank

  validates :chara, presence: true
  validates :rank,  presence: true
end
