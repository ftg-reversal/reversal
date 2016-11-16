# == Schema Information
#
# Table name: mikado_tenkaichi_vote_statuses
#
#  id               :integer          not null, primary key
#  reversal_user_id :integer          not null
#  can_vote         :boolean          default(TRUE), not null
#  created_at       :datetime
#  updated_at       :datetime
#

class MikadoTenkaichiVoteStatus < ApplicationRecord
  belongs_to :reversal_user
end
