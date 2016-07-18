class HomeController < ApplicationController
  def index
    @activities = Activity.including_all.recently.limit(30)
  end

  def about
  end
end
