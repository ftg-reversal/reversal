# == Schema Information
#
# Table name: mikado23on_entries
#
#  id         :integer          not null, primary key
#  area       :string(255)      not null
#  chara_id   :integer          not null
#  entry_num  :integer          not null
#  name       :string(255)      not null
#  twitter    :string(255)
#  rank_id    :integer          not null
#  comment    :string(255)      not null
#  count      :integer          default(0), not null
#  created_at :datetime
#  updated_at :datetime
#

class Mikado23onEntry < ApplicationRecord
  belongs_to :chara
  belongs_to :rank
end
