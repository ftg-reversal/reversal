class TopController < ApplicationController
  def index
    @videos = Video.order('posted_at DESC').limit(8)
    @lives = Live.order('start_time DESC').limit(8)
  end
end
