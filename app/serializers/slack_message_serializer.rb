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

class SlackMessageSerializer < ActiveModel::Serializer
  attributes :id, :slack_user, :username, :icon_url, :channel, :date, :format_text, :ts, :image, :attachments
  delegate :username, to: :object

  def icon_url
    object.icon
  end

  def channel
    object.slack_channel.name
  end

  def date
    scope.nil? ? object.date : scope.l(object.date)
  end
end
