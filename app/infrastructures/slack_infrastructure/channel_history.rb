module SlackInfrastructure
  class ChannelHistory
    class << self
      def exec(channel, cache: true)
        delete_cache(channel) unless cache

        Rails.cache.fetch(cache_key(channel), expires_in: 3.minutes) do
          client = SlackInfrastructure::SlackClient.exec
          client.channels_history(channel: channel.cid, count: 300)['messages'].map do |message|
            channel_format(channel, message)
          end
        end
      end

      private

      def cache_key(channel)
        "api_channel_history_#{channel.cid}"
      end

      def delete_cache(channel)
        Rails.cache.delete(cache_key(channel))
      end

      def channel_format(channel, message)
        {
          channel_id: channel.cid,
          user_id: message['user'],
          username: message['username'],
          text: message['text'],
          ts: BigDecimal(message['ts']),
          attachments: message['attachments'],
          file: message['file'],
          icon: message['icons']
        }
      end
    end
  end
end
