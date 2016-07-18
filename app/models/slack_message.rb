# == Schema Information
#
# Table name: slack_messages
#
#  id               :integer          not null, primary key
#  slack_channel_id :integer          default(0), not null
#  slack_user_id    :integer
#  username         :string(255)
#  icon             :text(65535)
#  ts               :decimal(16, 6)
#  text             :text(65535)
#  attachments      :text(65535)
#  file             :text(65535)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
# Indexes
#
#  channel_ts_index       (slack_channel_id,ts)
#  channel_user_ts_index  (slack_channel_id,slack_user_id,ts) UNIQUE
#  slack_channel_id       (slack_channel_id)
#  slack_user_id          (slack_user_id)
#  ts                     (ts)
#

class SlackMessage < ApplicationRecord
  paginates_per 30

  belongs_to :slack_channel
  belongs_to :slack_user
  has_many :slack_messages_summaries, dependent: :destroy
  has_many :summaries, through: :slack_messages_summaries

  serialize :attachments
  serialize :file
  serialize :icon
end
