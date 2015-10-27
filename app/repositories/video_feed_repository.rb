class VideoFeedRepository
  class << self
    # @param condition [VideoSiteSearchCondition]
    # @return [Array<Video>]
    def find_all_by_condition(condition)
      condition.video_site.search_infrastructure.exec(condition.word)
        .map { |hash| update_or_initialize_video(hash, condition) }
    end

    private

    # @param [Hash] hash
    # @param [VideoSiteSearchCondition] condition
    # @return [Video]
    def update_or_initialize_video(hash, condition)
      Video.find_or_initialize_by(url: hash[:url]).tap do |video|
        video.url = hash[:url]
        video.video_id = hash[:id]
        video.video_site = condition.video_site
        video.title = hash[:title]
        video.posted_at = hash[:posted_at]
      end
    end
  end
end
