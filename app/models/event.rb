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
end
