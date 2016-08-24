module YoutubeInfrastructure
  class VideoThumbnail
    class << self
      # @param id [String]
      # @return [String, nil]
      def exec(id)
        "https://i.ytimg.com/vi/#{id}/default.jpg"
      end
    end
  end
end
