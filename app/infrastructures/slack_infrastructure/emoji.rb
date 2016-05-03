module SlackInfrastructure
  class Emoji
    class << self
      # @return [Array<Hash>]
      def exec(cache = true)
        Rails.cache.delete('slack_emoji_api') unless cache

        Rails.cache.fetch('slack_emoji_api', expires_in: 3.minutes) do
          client = SlackInfrastructure::SlackClient.exec
          client.emoji_list['emoji'].tap do |list|
            list.map { |key, value| list[key] = list[$1] if value =~ /\Aalias:(.+)\z/ }
          end
        end
      end
    end
  end
end
