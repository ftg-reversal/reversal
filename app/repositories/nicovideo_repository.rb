class NicovideoRepository
  class << self
    def find_by_video_id(video_id)
      video = Video.find_by(video_id: video_id)
      return video if video

      hash = NicovideoInfrastructure::GetThumbInfo.exec(video_id)
      Video.new(
        url: hash[:url],
        video_id: hash[:id],
        video_site: VideoSite::Nicovideo,
        title: hash[:title],
        posted_at: hash[:posted_at]
      )
    end
  end
end
