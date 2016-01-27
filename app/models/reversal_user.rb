# == Schema Information
#
# Table name: reversal_users
#
#  id            :integer          not null, primary key
#  slack_user_id :string(255)
#  is_admin      :boolean
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
# Indexes
#
#  slack_user_id  (slack_user_id) UNIQUE
#

class ReversalUser < ActiveRecord::Base
  belongs_to :slack_user
end
