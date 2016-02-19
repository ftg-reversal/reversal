class SlackChannelsController < ApplicationController
  before_action :set_channels

  def index
  end

  def show
    @channel = SlackChannel.find_by(id: params[:id])
    @history = @channel.slack_message.decorate
  end

  private

  def set_channels
    @channels = SlackChannel.all
  end
end
