# == Schema Information
#
# Table name: messages
#
#  id               :integer          not null, primary key
#  room_id          :integer          default(0), not null
#  reversal_user_id :integer
#  user_name        :string(255)
#  icon             :text(65535)
#  text             :text(65535)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
# Indexes
#
#  index_messages_on_reversal_user_id  (reversal_user_id)
#  index_messages_on_room_id           (room_id)
#

class Message < ApplicationRecord
  belongs_to :room
  belongs_to :reversal_user

  serialize :tweet_content
end
