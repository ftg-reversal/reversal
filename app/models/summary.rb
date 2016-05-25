# == Schema Information
#
# Table name: summaries
#
#  id               :integer          not null, primary key
#  title            :string(255)      not null
#  description      :text(65535)      not null
#  reversal_user_id :integer          not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  slack_channel_id :integer          not null
#
# Indexes
#
#  index_summaries_on_reversal_user_id  (reversal_user_id)
#  index_summaries_on_slack_channel_id  (slack_channel_id)
#

class Summary < ActiveRecord::Base
  belongs_to :slack_channel
  belongs_to :reversal_user
  has_many :slack_messages_summaries
  has_many :slack_messages, through: :slack_messages_summaries
end
