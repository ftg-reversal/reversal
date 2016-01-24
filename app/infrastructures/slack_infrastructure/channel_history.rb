module SlackInfrastructure
  class ChannelHistory
    class << self
      # @param channel [SlackChannel]
      # @return [Array<Hash>]
      def exec(channel)
        client = SlackInfrastructure::SlackClient.exec
        client.channels_history({channel: channel.cid, count: 300})['messages'].map do |message|
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
  end
end
