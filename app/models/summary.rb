# == Schema Information
#
# Table name: rlogs
#
#  id               :integer          not null, primary key
#  title            :string(255)      not null
#  description      :text(65535)
#  reversal_user_id :integer          not null
#  slack_channel_id :integer
#  type             :string(255)      not null
#  created_at       :datetime
#  updated_at       :datetime
#
# Indexes
#
#  index_rlogs_on_reversal_user_id  (reversal_user_id)
#  index_rlogs_on_slack_channel_id  (slack_channel_id)
#  index_rlogs_on_type              (type)
#

class Summary < Rlog
  belongs_to :slack_channel
  has_many :slack_messages_summaries, dependent: :destroy
  has_many :slack_messages, through: :slack_messages_summaries

  include PublicActivity::Model

  scope :including_good,     -> () { includes(goods: [:reversal_user]) }
  scope :including_user,     -> () { includes(reversal_user: [:twitter_user, :slack_user]) }
  scope :including_message, -> () { includes(slack_messages: [:slack_user, :slack_channel]) }
  scope :including_all, -> () { including_good.including_user.including_message }

  def good?(user)
    !Good.user(user).type('Rlog').id(id).empty?
  end
end
