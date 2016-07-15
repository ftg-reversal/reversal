class Video::GoodsController < ApplicationController
  before_action :do_check_login, only: [:update, :destroy]
  before_action :set_video
  before_action :set_good, only: [:destroy]

  def update
    good = @video.goods.create!(
      reversal_user: @current_user,
      link: { title: @video.title, url: video_path(@video) }.to_json
    )
    good.create_activity :update, owner: @current_user

    render json: good
  end

  def destroy
    render json: @good.destroy
  end

  def show
    @goods = @video.goods
  end

  private

  def set_video
    @video = Video.find(params[:video_id])
  end

  def set_good
    @good = Good.user(@current_user).type('Video').id(@video.id).first
  end
end
