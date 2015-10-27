class VideoSite < ClassyEnum::Base
  # @param _ [String]
  # @return [String]
  def thumbnail_uri(_)
    VideoConfig.dummy_thumbnail_filepath
  end

  # @return [Class]
  def search_infrastructure
    nil
  end
end

class VideoSite::Dummy < VideoSite
end

class VideoSite::Nicovideo < VideoSite
  # @param id [String]
  # @return [String, nil]
  def thumbnail_uri(id)
    NicovideoInfrastructure::VideoThumbnail.exec(id)
  end

  # @return [Class]
  def search_infrastructure
    NicovideoInfrastructure::TagSearch
  end
end

class VideoSite::Youtube < VideoSite
  # @param id [String]
  # @return [String, nil]
  def thumbnail_uri(id)
    YoutubeInfrastructure::VideoThumbnail.exec(id)
  end

  # @return [Class]
  def search_infrastructure
    YoutubeInfrastructure::Search
  end
end
