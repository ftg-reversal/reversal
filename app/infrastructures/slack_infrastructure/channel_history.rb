module SlackInfrastructure
  class ChannelHistory
    class << self
      # rubocop:disable all
      def exec(channel, cache = true)
        Rails.cache.delete("api_channel_history_#{channel.cid}") unless cache

        Rails.cache.fetch("api_channel_history_#{channel.cid}", expires_in: 3.minutes) do
          client = SlackInfrastructure::SlackClient.exec
          client.channels_history(channel: channel.cid, count: 300)['messages'].map do |message|
            {
              channel_id: channel.cid,
              user_id: message['user'],
              text: message['text'],
              ts: BigDecimal(message['ts']),
              attachments: message['attachments'],
              file: message['file']
            }
          end
        end
      end
      # rubocop:enable all
    end
  end
end
