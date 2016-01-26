module SlackInfrastructure
  class Emoji
    class << self
      # @return [Array<Hash>]
      def exec
        client = SlackInfrastructure::SlackClient.exec
        @list ||= client.emoji_list['emoji'].tap do |list|
          list.map do |key, value|
            if value =~ /\Aalias:(.+)\z/
              list[key] = list[$1]
            end
          end
        end
      end
    end
  end
end
