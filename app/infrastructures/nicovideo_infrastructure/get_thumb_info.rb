require 'rexml/document'

module NicovideoInfrastructure
  class GetThumbInfo
    class << self
      def exec(video_id)
        xml = REXML::Document.new(open("http://ext.nicovideo.jp/api/getthumbinfo/#{video_id}"))
        hash = Hash.from_xml(xml.to_s)

        {
          id: video_id,
          url: hash['nicovideo_thumb_response']['thumb']['watch_url'],
          title: hash['nicovideo_thumb_response']['thumb']['title'],
          posted_at: hash['nicovideo_thumb_response']['thumb']['first_retrieve']
        }
      end
    end
  end
end
