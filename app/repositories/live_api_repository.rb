class LiveApiRepository
  class << self
    # @return [Array<Live>]
    def find_nicovideo_live
      VideoSiteSearchCondition.where(video_site: VideoSite[:nicovideo].to_s).flat_map do |condition|
        NicovideoInfrastructure::LiveSearch.exec(condition.word).map { |hash| update_or_initialize_live(hash) }
      end
    end

    private

    # @param [Hash] hash
    # @return [Video]
    def update_or_initialize_live(hash)
      Live.find_or_initialize_by(url: hash[:url]).tap do |live|
        live.live_id = hash[:id]
        live.url = hash[:url]
        live.title = hash[:title]
        live.start_time = hash[:start_time]
        live.icon_url = hash[:icon_url]
      end
    end
  end
end
