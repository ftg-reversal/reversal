module SlackInfrastructure
  class ChannelList
    class << self
      # @return [Array<Hash>]
      def exec
        client = SlackInfrastructure::SlackClient.exec
        client.channels_list['channels'].map do |channel|
          {
            channel_id: channel['id'],
            name: channel['name'],
            topic: channel['topic']['value'],
            is_archived: channel['is_archived']
          }
        end
      end
    end
  end
end
