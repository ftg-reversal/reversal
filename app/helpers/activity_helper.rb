module ActivityHelper
  def activity_type(activity)
    activity.trackable_type
  end
end
