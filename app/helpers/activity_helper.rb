module ActivityHelper
  def activity_type(activity)
    return nil if activity.trackable.nil?
    activity.trackable_type
  end
end
