module Batch
  class UpdateVideos
    class << self
      def exec
        VideoSiteSearchCondition.all.flat_map do |condition|
          videos = VideoFeedRepository.find_all_by_condition(condition).select(&:validate)
          videos.map { |video| save(video) }
        end
      end

      private

      # @param [Video]
      # @return [Boolean]
      def save(video)
        # VideoUpdateNotificatorService.tweet(video)
        video.save
      end
    end
  end
end
