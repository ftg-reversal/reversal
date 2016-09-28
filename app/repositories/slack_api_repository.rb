class SlackApiRepository
  class << self
    def find_all_channels
      SlackInfrastructure::ChannelList.exec.map do |hash|
        SlackChannel.find_or_initialize_by(cid: hash[:channel_id]).tap do |channel|
          channel.name = hash[:name]
          channel.is_archived = hash[:is_archived]
        end
      end
    end

    def find_all_users
      SlackInfrastructure::UserList.exec.map do |hash|
        SlackUser.find_or_initialize_by(uid: hash[:user_id]).tap do |user|
          user.name = hash[:name]
          user.icon_url = hash[:icon_url]
        end
      end
    end

    # rubocop:disable Metrics/AbcSize,Metrics/MethodLength
    def find_all_messages_by_channel(channel, cache: true)
      SlackInfrastructure::ChannelHistory.exec(channel, cache: cache).map do |hash|
        user = SlackUser.find_by(uid: hash[:user_id])
        SlackMessage.find_or_initialize_by(slack_channel_id: channel.id,
                                           slack_user_id: user&.id,
                                           ts: hash[:ts]).tap do |message|
          message.slack_channel = channel
          message.slack_user = user
          message.username = hash[:username]
          message.text = hash[:text]
          message.ts = hash[:ts]
          message.attachments = hash[:attachments] || []
          message.file = hash[:file]
          message.icon = hash[:icon]
        end
      end
    end
    # rubocop:enable Metrics/MethodLength

    def find_all_deleted_messages(channel, cache: true)
      api_messages = SlackInfrastructure::ChannelHistory.exec(channel, cache: cache)
      oldest_api_message = api_messages.last
      SlackMessage.where(slack_channel: channel).order(ts: 'desc').limit(300).select do |message|
        oldest_api_message[:ts] < message.ts && api_messages.none? do |api_message|
          api_message[:channel_id] == message.slack_channel.cid &&
            api_message[:user_id] == message.slack_user&.uid &&
            api_message[:ts] == message.ts
        end
      end
    end
    # rubocop:enable Metrics/AbcSize

    def post_message(channel, text, username, icon_emoji: nil, icon_url: nil)
      SlackInfrastructure::PostMessage.exec(channel.name, text, username, icon_emoji: icon_emoji, icon_url: icon_url)
    end
  end
end
