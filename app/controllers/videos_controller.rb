class VideosController < ApplicationController
  def index
    @charas = Chara.all
    @videos = Video.order('posted_at DESC').includes(video_matchups: [:chara1, :chara2]).page(params[:page])
  end
end
