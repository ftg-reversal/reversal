# == Schema Information
#
# Table name: mikado_tenkaichi_votes
#
#  id                        :integer          not null, primary key
#  reversal_user_id          :integer          not null
#  mikado_tenkaichi_entry_id :integer
#  created_at                :datetime
#  updated_at                :datetime
#

class MikadoTenkaichiVote < ApplicationRecord
  belongs_to :reversal_user
  belongs_to :mikado_tenkaichi_entry
end
