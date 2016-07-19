class UpdateVideos
  class << self
    def exec
      VideoSiteSearchCondition.all.flat_map do |condition|
        videos = VideoFeedRepository.find_all_by_condition(condition).select(&:validate)
        videos.map do |video|
          save(video) if video.changed?
        end
      end
    end

    private

    # @param [Video]
    # @return [Boolean]
    def save(video)
      # VideoUpdateNotifier.tweet(video)
      video.save
    end
  end
end
