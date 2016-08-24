require 'rss'

class NicovideoInfrastructure::TagSearch
  class << self
    # @param tag [String]
    # @return [Hash{String => String}]
    def exec(tag)
      items(rss_url(tag)).map do |video|
        {
          id:       video.link.split('/').pop,
          url:       video.link,
          title:     video.title,
          posted_at: video.pubDate
        }
      end
    end

    def api_exec(tag)
      api_client.search(tag, search: [:tags_exact], sort_by: :start_time, order: :desc, size: 100).map do |video|
        {
          id:        video.cmsid,
          url:       "http://www.nicovideo.jp/watch/#{video.cmsid}",
          title:     video.title,
          posted_at: video.start_time
        }
      end
    end

    private

    # @param tag [String]
    # @return [String]
    def rss_url(tag)
      "http://www.nicovideo.jp/tag/#{tag}?sort=f&rss=2.0"
    end

    # @param url [String]
    # @return [Array<RSS::Rss::Channel::Item>]
    def items(url)
      RSS::Parser.parse(url, true).channel.items.reverse
    end

    def api_client
      @client ||= NicoSearchSnapshot.new('video')
    end
  end
end
