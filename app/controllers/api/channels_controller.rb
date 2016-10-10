class Api::ChannelsController < ApplicationController
  def index
    channels = SlackChannel.where(is_archived: false).order(:name)
    render json: channels, each_serializer: ChannelSerializer
  end

  def show
    render json: ChannelSerializer.new(SlackChannel.find(params[:id]))
  end
end
