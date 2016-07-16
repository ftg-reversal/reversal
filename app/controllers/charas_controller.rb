class CharasController < ApplicationController
  # rubocop:disable Metrics/AbcSize
  def video
    @charas = Chara.all
    @chara = Chara.where('lower(en_name) = ?', params[:chara_name].downcase).first
    @videos = Video.including_matchup.chara1(@chara).recently.counts.goods
                   .or(Video.including_matchup.chara2(@chara).recently.counts.goods)
                   .page(params[:page])

    render 'videos/index'
  end
  # rubocop:enable Metrics/AbcSize
end
