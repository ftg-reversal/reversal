class SlackInfrastructure::ChannelList
  class << self
    # @return [Array<Hash>]
    def exec
      client = SlackInfrastructure::SlackClient.exec
      client.channels_list['channels'].map do |channel|
        {
          channel_id: channel['id'],
          name: channel['name']
        }
      end
    end
  end
end
