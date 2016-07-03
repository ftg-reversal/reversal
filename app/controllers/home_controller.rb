class HomeController < ApplicationController
  def index
    @activities = PublicActivity::Activity.includes(:owner)
                                          .includes(:trackable)
                                          .includes(:recipient)
                                          .order('updated_at DESC')
                                          .limit(20)
  end
end
