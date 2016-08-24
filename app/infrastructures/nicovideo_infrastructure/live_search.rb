class NicovideoInfrastructure::LiveSearch
  class << self
    # @param query [String]
    # @return [Hash{String => String}]
    # rubocop:disable Metrics/LineLength, Metrics/MethodLength
    def exec(query)
      res = open("http://api.search.nicovideo.jp/api/v2/live/contents/search?q=#{query}&targets=tags&fields=contentId,title,startTime,communityIcon&_sort=-startTime&filters[liveStatus][0]=onair&_offset=0&_limit=100&_context=reversal")
      code, = res.status

      if code == '200'
        ActiveSupport::JSON.decode(res.read)['data'].map do |live|
          {
            id:         live['contentId'],
            url:        "http://live.nicovideo.jp/watch/#{live['contentId']}",
            title:      live['title'],
            start_time: live['startTime'],
            icon_url:   live['communityIcon']
          }
        end
      else
        []
      end
    end
    # rubocop:enable Metrics/LineLength, Metrics/MethodLength
  end
end
