class VideosController < ApplicationController
  before_action :set_charas, only: [:index, :search]
  before_action :set_video, only: [:show]
  before_action :set_good, only: [:show]

  def index
    @videos = Video.order('posted_at DESC').including_matchup.page(params[:page])
  end

  def show; end

  def search
    @q = params[:text]
    @q_type = 'Video'
    @videos = Video
      .ransack(title_or_url_cont: params[:text])
      .result
      .order('posted_at DESC')
      .including_matchup
      .page(params[:page])
    render 'index'
  end

  private

  def set_charas
    @charas = Chara.all
  end

  def set_video
    @video = Video.includes(video_matchups: [:chara1, :chara2]).find(params[:id])
  end

  def set_good
    @good = Good.user(@current_user).type('Video').id(@video.id).first
  end
end
