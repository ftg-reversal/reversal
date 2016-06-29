# == Schema Information
#
# Table name: events
#
#  id               :integer          not null, primary key
#  reversal_user_id :integer          not null
#  title            :string(255)
#  description      :text(65535)
#  datetime         :datetime
#  entry_deadline   :datetime
#  number           :integer          default(1), not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
# Indexes
#
#  events_on_reversal_user_id                              (reversal_user_id)
#  index_events_on_datetime                                (datetime)
#  index_events_on_datetime_and_entry_deadline_and_number  (datetime,entry_deadline,number)
#  index_events_on_datetime_and_number                     (datetime,number)
#  index_events_on_entry_deadline                          (entry_deadline)
#  index_events_on_entry_deadline_and_number               (entry_deadline,number)
#  index_events_on_number                                  (number)
#

class Event < ActiveRecord::Base
  has_many :entry, dependent: :destroy
  belongs_to :reversal_user

  validates :title, presence: true
  validates :description, presence: true
  validates :datetime, presence: true
  validates :number, presence: true
  validates :reversal_user_id, presence: true

  scope :recently, -> () { order('datetime ASC') }
  scope :including_user, -> () { includes(:reversal_user) }
  scope :including_entry, -> () { includes(entry: [:reversal_user, entry_player: [:chara, :rank]]) }

  scope :upcoming, -> () { where('datetime >= ?', tomorrow).including_user }
  scope :finished, -> () { where('datetime < ?', tomorrow).including_user }

  def can_entry?
    if entry_deadline
      DateTime.current < entry_deadline
    else
      DateTime.current < datetime
    end
  end

  class << self
    def tomorrow
      Date.tomorrow.in_time_zone
    end
  end
end
