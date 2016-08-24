class YoutubeInfrastructure::Search
  class << self
    # @param query [String]
    # @return [Hash{String => String}]
    def exec(query)
      yt = Yt::Collections::Videos.new
      yt.where(q: query).to_enum.take(100).map do |video|
        {
          id:        video.id,
          url:       "https://www.youtube.com/watch?v=#{video.id}",
          title:     video.snippet.data['title'],
          posted_at: video.snippet.data['publishedAt']
        }
      end
    end
  end
end
