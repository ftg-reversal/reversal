class HomeController < ApplicationController
  def index
    activities = Activity.including_all.recently.limit(500)

    activities = activities.select { |activity| !activity.trackable.nil? }.first(60)
    @activities = Kaminari.paginate_array(activities).page(params[:page])
  end

  def about
  end
end
