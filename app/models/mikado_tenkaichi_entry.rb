# == Schema Information
#
# Table name: mikado_tenkaichi_entries
#
#  id         :integer          not null, primary key
#  chara_id   :integer          not null
#  name       :string(255)      not null
#  twitter    :string(255)      not null
#  rank_id    :integer          not null
#  comment    :string(255)      not null
#  count      :integer          default(0), not null
#  created_at :datetime
#  updated_at :datetime
#

class MikadoTenkaichiEntry < ApplicationRecord
  belongs_to :chara
  belongs_to :rank
end
