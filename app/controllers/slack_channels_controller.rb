class SlackChannelsController < ApplicationController
  before_action :set_channels

  def index
  end

  def show
    @channel = SlackChannel.including_channel_user.find(params[:id])
    @history = SlackMessagesDecorator.decorate(@channel.slack_message.page(params[:page]))
  end

  def search
    @q = params[:text]
    @q_type = 'Message'
    @history = SlackMessagesDecorator.decorate(SlackMessage.where('attachments LIKE ?', "%#{params[:text]}%").order('updated_at DESC').page(params[:page]))
    render 'show'
  end

  private

  def set_channels
    @channels = SlackChannel.order(:name)
  end
end
