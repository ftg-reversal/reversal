class SearchController < ApplicationController
  # rubocop:disable Metrics/AbcSize,Metrics/MethodLength
  def index
    if params[:search][:type] == 'Video'
      redirect_to controller: :videos, action: :search, text: params[:search][:text]
    elsif params[:search][:type] == 'Message'
      redirect_to controller: :slack_channels, action: :search, text: params[:search][:text]
    elsif params[:search][:type] == 'Page'
      redirect_to controller: :pages, action: :search, text: params[:search][:text]
    elsif params[:search][:type] == 'Summary'
      redirect_to controller: :summaries, action: :search, text: params[:search][:text]
    elsif params[:search][:type] == 'Event'
      redirect_to controller: :events, action: :search, text: params[:search][:text]
    else
      raise
    end
  end
  # rubocop:enable Metrics/AbcSize,Metrics/MethodLength
end
