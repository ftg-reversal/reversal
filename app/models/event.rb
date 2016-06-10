# == Schema Information
#
# Table name: events
#
#  id               :integer          not null, primary key
#  title            :string(255)
#  description      :text(65535)
#  datetime         :datetime
#  reversal_user_id :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  entry_deadline   :datetime
#  number           :integer          default(1), not null
#
# Indexes
#
#  fk_rails_337cdb79bb  (reversal_user_id)
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
