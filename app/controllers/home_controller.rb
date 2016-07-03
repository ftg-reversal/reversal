class HomeController < ApplicationController
  def index
    @activities = PublicActivity::Activity.includes(:owner)
                                          .includes(:trackable)
                                          .includes(:recipient)
                                          .order('updated_at DESC')
                                          .page(params[:page])
  end
end
