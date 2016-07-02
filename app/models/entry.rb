# == Schema Information
#
# Table name: entries
#
#  id               :integer          not null, primary key
#  reversal_user_id :integer          not null
#  event_id         :integer          not null
#  comment          :text(65535)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
# Indexes
#
#  index_entries_on_event_id          (event_id)
#  index_entries_on_reversal_user_id  (reversal_user_id)
#

class Entry < ActiveRecord::Base
  has_many :entry_player, dependent: :destroy
  belongs_to :event
  belongs_to :reversal_user

  validates :event, presence: true
  validate :expiration_date_cannot_entry, :exist_entry

  def user
    reversal_user
  end

  def expiration_date_cannot_entry
    errors.add(:can_entry, 'エントリー締め切りを過ぎています') unless event.can_entry?
  end

  def exist_entry
    errors.add(:exist_entry, '既にエントリーされています') if event.entry.map(&:user).include?(user)
  end
end
