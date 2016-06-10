class SlackChannelsController < ApplicationController
  before_action :set_channels

  def index
  end

  def show
    @channel = SlackChannel.including_channel_user.find(params[:id])
    @history = SlackMessagesDecorator.decorate(@channel.slack_message.page(params[:page]))
  end

  private

  def set_channels
    @channels = SlackChannel.order(:name)
  end
end
