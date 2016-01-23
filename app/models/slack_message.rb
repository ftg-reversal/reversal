# == Schema Information
#
# Table name: slack_messages
#
#  id         :integer          not null, primary key
#  channel    :string(255)
#  user       :string(255)
#  type       :string(255)
#  ts         :float(24)
#  text       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  channel                (channel)
#  channel_user_ts_index  (channel,user,ts) UNIQUE
#  ts                     (ts)
#  user                   (user)
#

class SlackMessage < ActiveRecord::Base
end
