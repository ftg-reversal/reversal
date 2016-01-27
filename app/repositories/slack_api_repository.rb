class SlackApiRepository
  class << self
    # @return [Array<SlackChannel>]
    def find_all_channels
      SlackInfrastructure::ChannelList.exec.map do |hash|
        SlackChannel.find_or_initialize_by(cid: hash[:channel_id]) do |channel|
          channel.name = hash[:name]
          channel.topic = hash[:topic]
          channel.is_archived = hash[:is_archived]
        end
      end
    end

    # @return [Array<SlackUser>]
    def find_all_users
      SlackInfrastructure::UserList.exec.map do |hash|
        SlackUser.find_or_initialize_by(uid: hash[:user_id]) do |user|
          user.name = hash[:name]
          user.icon_url = hash[:icon_url]
        end
      end
    end

    # @param channel[SlackChannel]
    # @return [Array<SlackMessage>]
    def find_all_messages_by_channel(channel)
      SlackInfrastructure::ChannelHistory.exec(channel, cache: true).map do |hash|
        user = SlackUser.find_by(uid: hash[:user_id])
        SlackMessage.find_or_initialize_by(slack_channel_id: channel.id, slack_user_id: user.id, ts: hash[:ts]) do |message|
          message.slack_channel = channel
          message.slack_user = user
          message.text = hash[:text]
          message.ts = hash[:ts]
          message.attachments = hash[:attachments] || []
          message.file = hash[:file]
        end
      end
    end

    # @param channel[SlackChannel]
    # @return [Array<SlackMessage>]
    def find_all_deleted_messages_by_channel(channel)
      api_messages = SlackInfrastructure::ChannelHistory.exec(channel, cahce: true)
      oldest_api_message = api_messages.last
      SlackMessage.where(slack_channel: channel).order(ts: 'desc').limit(300).select do |message|
        oldest_api_message[:ts] < message.ts && api_messages.none? do |api_message|
          api_message[:channel_id] == message.slack_channel.cid &&
           api_message[:user_id] == message.slack_user.uid &&
           api_message[:ts] == message.ts
        end
      end
    end

    def find_original_emoji_set
      SlackInfrastructure::Emoji.exec
    end
  end
end
