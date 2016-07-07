class HomeController < ApplicationController
  def index
    activities = PublicActivity::Activity.includes(:owner)
                                          .includes(:trackable)
                                          .includes(:recipient)
                                          .order('updated_at DESC')
                                          .limit(500)

    activities = activities.select { |activity| !activity.trackable.nil? }.first(60)
    @activities = Kaminari.paginate_array(activities).page(params[:page])
  end
end
