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

class Rlog < ActiveRecord::Base
  include Goodable

  belongs_to :reversal_user
  belongs_to :slack_channel
  has_many :slack_messages_summaries, dependent: :destroy
  has_many :slack_messages, through: :slack_messages_summaries
  has_many :goods, as: :goodable, dependent: :destroy

  validates :title, presence: true, length: { maximum: 100 }
  validates :reversal_user, presence: true
end
