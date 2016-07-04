module ActivityHelper
  def activity_type(activity)
    if activity.trackable.class.to_s == 'NilClass'
    else
      activity.trackable_type
    end
  end
end
