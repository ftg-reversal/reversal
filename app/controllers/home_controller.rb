class HomeController < ApplicationController
  def index
    @activities = Activity.including_all.not_matchup.recently.limit(30)
  end

  def about; end
end
