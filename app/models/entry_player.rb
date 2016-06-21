# == Schema Information
#
# Table name: entry_players
#
#  id       :integer          not null, primary key
#  name     :string(255)
#  chara_id :integer
#  rank_id  :integer
#  entry_id :integer
#
# Indexes
#
#  fk_rails_001d489769  (rank_id)
#  fk_rails_53cb378c6b  (chara_id)
#  fk_rails_c0b8648e8b  (entry_id)
#

class EntryPlayer < ActiveRecord::Base
  belongs_to :entry
  belongs_to :chara
  belongs_to :rank

  validates :chara, presence: true
  validates :rank,  presence: true
end
