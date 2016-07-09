class VideosController < ApplicationController
  before_action :set_video, only: [:show]
  before_action :set_good, only: [:show]

  def index
    @charas = Chara.all
    @videos = Video.order('posted_at DESC').includes(video_matchups: [:chara1, :chara2]).page(params[:page])
  end

  def show
  end

  private

  def set_video
    @video = Video.includes(video_matchups: [:chara1, :chara2]).find(params[:id])
  end

  def set_good
    @good = Good.user(@current_user).type('Video').id(@video.id).first
  end
end
