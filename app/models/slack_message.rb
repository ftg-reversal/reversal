# == Schema Information
#
# Table name: slack_messages
#
#  id               :integer          not null, primary key
#  slack_channel_id :integer
#  slack_user_id    :integer
#  ts               :decimal(16, 6)
#  text             :text(65535)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  attachments      :text(65535)
#  file             :text(65535)
#  username         :string(255)
#  icon             :string(255)
#
# Indexes
#
#  channel_ts_index       (slack_channel_id,ts)
#  channel_user_ts_index  (slack_channel_id,slack_user_id,ts) UNIQUE
#  slack_channel_id       (slack_channel_id)
#  slack_user_id          (slack_user_id)
#  ts                     (ts)
#

class SlackMessage < ActiveRecord::Base
  paginates_per 30

  belongs_to :slack_channel
  belongs_to :slack_user

  serialize :attachments
  serialize :file
  serialize :icon
end
