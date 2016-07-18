# == Schema Information
#
# Table name: twitter2slack_conditions
#
#  id               :integer          not null, primary key
#  text             :string(255)      not null
#  slack_channel_id :integer          not null
#  last_tweet       :integer          default(0), not null
#  quote            :boolean          default(FALSE), not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
# Indexes
#
#  index_twitter2slack_conditions_on_slack_channel_id  (slack_channel_id)
#

class Twitter2slackCondition < ApplicationRecord
  belongs_to :slack_channel
end
