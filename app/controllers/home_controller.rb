class HomeController < ApplicationController
  def index
    @videos = Video.order('posted_at DESC').limit(3)
    @pages = Page.order('updated_at DESC').limit(3)
    @summaries = Summary.order('updated_at DESC').limit(3)
    @events = Event.upcoming.recently.limit(3)
  end
end
