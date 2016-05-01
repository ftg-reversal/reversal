module Api
  class ChannelsController < ApplicationController
    def index
      channels = SlackChannel.all
      render json: channels, each_serializer: ChannelApiSerializer, root: nil
    end

    def show
      messages = SlackChannel.find(params[:id]).slack_message.limit(300).map(&:decorate)
      render json: messages, each_serializer: MessageApiSerializer, root: nil
    end
  end
end
