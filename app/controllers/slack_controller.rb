class SlackController < ApplicationController
  before_action :set_channels

  def index
  end

  def show
    @channel = SlackChannel.find_by(name: params[:channel])
    @history = @channel.slack_message.decorate
  end

  private

  def set_channels
    @channels = SlackChannel.all
  end
end
