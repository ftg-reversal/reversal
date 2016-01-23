module Batch
  class UpdateSlack
    class << self
      def exec
        SlackApiRepository.find_all_channel.select(&:validate).map(&:save)
        SlackApiRepository.find_all_user.select(&:validate).map(&:save)
        SlackChannel.all.map do |channel|
          SlackApiRepository.find_all_message_by_channel(channel).select(&:validate).map(&:save)
        end
      end
    end
  end
end
