class Api::Channel::MessagesController < ApplicationController
  def index
    channel = SlackChannel.find(params[:channel_id])
    messages = channel.slack_message.includes(:slack_channel).limit(300).map(&:decorate)
    render json: messages, each_serializer: SlackMessageSerializer
  end
end
