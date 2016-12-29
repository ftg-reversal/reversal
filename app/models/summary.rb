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
#  goods_count      :integer          default(0), not null
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
  attr_accessor :row_orders

  belongs_to :slack_channel
  has_many :slack_messages_summaries, dependent: :destroy
  has_many :slack_messages, through: :slack_messages_summaries

  include PublicActivity::Model

  scope :including_good,    -> () { includes(goods: [:reversal_user]) }
  scope :including_user,    -> () { includes(reversal_user: [:twitter_user, :slack_user]) }
  scope :including_message, -> () { includes(slack_messages: [:slack_user, :slack_channel]) }
  scope :including_all,     -> () { including_good.including_user.including_message }

  after_save :save_order

  def save_order
    slack_messages_summaries.map do |message_summary|
      message_summary.row_order = row_orders.map(&:to_i).index(message_summary.slack_message_id)
      message_summary.save!
    end
  end

  def good?(user)
    !Good.user(user).type('Rlog').id(id).empty?
  end
end
