# == Schema Information
#
# Table name: slack_channels
#
#  id         :integer          not null, primary key
#  cid        :string(255)      not null
#  name       :string(255)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  cid                           (cid) UNIQUE
#  index_slack_channels_on_name  (name)
#

class SlackChannel < ApplicationRecord
  has_many :slack_message, -> { order(ts: 'desc') }

  scope :including_channel_user, -> () { includes(slack_message: [:slack_user]) }
end
