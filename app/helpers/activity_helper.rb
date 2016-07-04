module ActivityHelper
  def activity_type(activity)
    activity.trackable.class.to_s || activity.trackable_type
  end
end
