class Api::VideoMatchupsController < ApplicationController
  before_action :do_check_login, only: [:create, :destroy]
  before_action :set_video, only: [:create]

  def index
    matchups = Video.including_matchup.find(params[:video_id]).video_matchups.order(:sec)
    render json: matchups, each_serializer: VideoMatchupSerializer
  end

  def create
    matchup = @video.video_matchups.create!(matchup_params)
    matchup.create_activity :update, owner: @current_user
    render nothing: true
  end

  def destroy
    matchup = VideoMatchup.find(params[:id])
    matchup.create_activity :destroy, owner: @current_user
    VideoMatchup.find(params[:id]).destroy!
    render nothing: true
  end

  private

  def set_video
    @video = Video.find(params[:video_id])
  end

  def matchup_params
    params.permit(:sec, :chara1_id, :chara2_id)
  end
end
