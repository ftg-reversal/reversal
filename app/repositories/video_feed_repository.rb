class VideoFeedRepository
  class << self
    def find_all_by_condition(condition)
      infrastructure = condition_to_infrastructure(condition)
      infrastructure.exec(condition.word).map { |hash| update_or_initialize_video(hash, condition) }
    end

    def condition_to_infrastructure(condition)
      condition.video_site.search_infrastructure
    end

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
