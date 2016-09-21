# == Schema Information
#
# Table name: mikado23on_vote_statuses
#
#  id               :integer          not null, primary key
#  reversal_user_id :integer          not null
#  can_east         :boolean          default(TRUE), not null
#  can_west         :boolean          default(TRUE), not null
#

class Mikado23onVoteStatus < ApplicationRecord
  belongs_to :reversal_user
end
