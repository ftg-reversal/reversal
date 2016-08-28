# == Schema Information
#
# Table name: activities
#
#  id             :integer          not null, primary key
#  trackable_id   :integer
#  trackable_type :string(255)
#  owner_id       :integer
#  owner_type     :string(255)
#  key            :string(255)
#  parameters     :text(65535)
#  recipient_id   :integer
#  recipient_type :string(255)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
# Indexes
#
#  index_activities_on_owner_id_and_owner_type          (owner_id,owner_type)
#  index_activities_on_recipient_id_and_recipient_type  (recipient_id,recipient_type)
#  index_activities_on_trackable_id_and_trackable_type  (trackable_id,trackable_type)
#

class Activity < PublicActivity::Activity
  self.abstract_class = true

  scope :including_owner, -> () { includes(owner: [:slack_user, :twitter_user]) }
  scope :including_trackable, -> () { includes(:trackable) }
  scope :including_recipient, -> () { includes(:recipient) }
  scope :including_all, -> () { including_owner.including_trackable.including_recipient }
  scope :select_user, -> (user) { where(owner: user) }
  scope :not_matchup, -> () { where.not(trackable_type: 'VideoMatchup') }
  scope :recently, -> () { order('updated_at DESC') }
end
