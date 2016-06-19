# == Schema Information
#
# Table name: rlogs
#
#  id               :integer          not null, primary key
#  title            :string(255)      not null
#  description      :text(65535)
#  slack_channel_id :integer
#  reversal_user_id :integer          not null
#  type             :string(255)      not null
#  created_at       :datetime
#  updated_at       :datetime
#
# Indexes
#
#  fk_rails_9daab45809              (slack_channel_id)
#  index_rlogs_on_reversal_user_id  (reversal_user_id)
#  index_rlogs_on_type              (type)
#

class Rlog < ActiveRecord::Base
  belongs_to :reversal_user
  belongs_to :slack_channel
  has_many :slack_messages_summaries, dependent: :destroy
  has_many :slack_messages, through: :slack_messages_summaries

  validates :title, presence: true
  validates :reversal_user_id, presence: true
end
