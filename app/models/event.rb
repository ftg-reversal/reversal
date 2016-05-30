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
#
# Indexes
#
#  fk_rails_337cdb79bb  (reversal_user_id)
#

class Event < ActiveRecord::Base
  has_many :entry
  belongs_to :reversal_user

  validates :title, presence: true
  validates :description, presence: true
  validates :datetime, presence: true
  validates :reversal_user_id, presence: true

  scope :recently, -> () { order('datetime ASC') }
  scope :including_user, -> () { includes(:reversal_user) }

  scope :upcoming, -> () { where('datetime >= ?', tomorrow).including_user }
  scope :finished, -> () { where('datetime < ?', tomorrow).including_user }

  def self.tomorrow
    Date.tomorrow.in_time_zone
  end
end
