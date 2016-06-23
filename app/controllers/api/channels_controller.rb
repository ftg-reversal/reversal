module Api
  class ChannelsController < ApplicationController
    def index
      channels = SlackChannel.all
      render json: channels, each_serializer: ChannelApiSerializer, root: nil
    end

    def show
      channel = SlackChannel.find(params[:id])
      # SlackApiRepository.find_all_messages_by_channel(channel, cache: false).select(&:validate).map(&:save)
      # SlackApiRepository.find_all_deleted_messages(channel, cache: true).map(&:destroy)
      messages = channel.slack_message.includes(:slack_channel).limit(300).map(&:decorate)
      render json: messages, each_serializer: MessageApiSerializer, root: nil
    end
  end
end
