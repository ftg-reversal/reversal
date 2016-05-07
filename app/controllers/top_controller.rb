class TopController < ApplicationController
  def index
    @videos = Video.order('updated_at DESC').limit(3)
    @pages = Page.order('updated_at DESC').limit(3)
    @summaries = Summary.order('updated_at DESC').limit(3)
    @events = Event.order('updated_at DESC').limit(3)
  end
end
