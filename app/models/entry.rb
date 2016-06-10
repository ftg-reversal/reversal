# == Schema Information
#
# Table name: entries
#
#  id               :integer          not null, primary key
#  comment          :text(65535)
#  event_id         :integer
#  reversal_user_id :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
# Indexes
#
#  fk_rails_20eb5df311  (event_id)
#  fk_rails_6a9722b611  (reversal_user_id)
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

  class << self
    def find_by_user(user)
      # TODO: あとで削除する
      find_by(reversal_user: user)
    end
  end
end
