module Batch
  class UpdateSlack
    class << self
      def exec
        SlackApiRepository.find_all_channels.select(&:validate).map(&:save)
        SlackApiRepository.find_all_users.select(&:validate).map(&:save)
        SlackChannel.all.map do |channel|
          SlackApiRepository.find_all_messages_by_channel(channel).select(&:validate).map(&:save)
          SlackApiRepository.find_all_deleted_messages(channel).map(&:destroy)
        end
      end
    end
  end
end
