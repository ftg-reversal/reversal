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
  validates :reversal_user_id, presence: true

  scope :recently, -> () { order('datetime ASC') }
  scope :including_user, -> () { includes(:reversal_user) }
  scope :including_all, -> () { includes(entry: [:rank, :reversal_user, :twitter_user, :chara]) }

  scope :upcoming, -> () { where('datetime >= ?', tomorrow).including_user }
  scope :finished, -> () { where('datetime < ?', tomorrow).including_user }

  def can_entry?
    if entry_deadline
      DateTime.now < entry_deadline
    else
      DateTime.now < datetime
    end
  end

  class << self
    def tomorrow
      Date.tomorrow.in_time_zone
    end
  end
end
