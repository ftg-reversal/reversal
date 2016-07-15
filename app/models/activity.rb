class Activity < PublicActivity::Activity
  scope :including_owner, -> () { includes(:owner) }
  scope :including_trackable, -> () { includes(:trackable) }
  scope :including_recipient, -> () { includes(:recipient) }
  scope :including_all, -> () { including_owner.including_trackable.including_recipient }
  scope :select_user, -> (user) { where(owner: user) }
  scope :recently, -> () { order('updated_at DESC') }
end
