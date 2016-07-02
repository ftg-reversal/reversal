class CharasController < ApplicationController
  # rubocop:disable Metrics/AbcSize
  def video
    @charas = Chara.all
    @chara = Chara.find(params[:chara_id])
    @videos = Video.order(:sec).includes(video_matchups: [:chara1, :chara2])
      .where(video_matchups: { chara1: @chara }).references(:video_matchups).order('posted_at DESC')
      .or(Video.order(:sec).includes(video_matchups: [:chara1, :chara2])
      .where(video_matchups: { chara2: @chara }).references(:video_matchups).order('posted_at DESC'))
      .page(params[:page])

    render 'videos/index'
  end
  # rubocop:enable Metrics/AbcSize
end
