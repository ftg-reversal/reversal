module NicovideoInfrastructure
  class VideoThumbnail
    class << self
      # @param id [String]
      # @return [String, nil]
      def exec(id)
        _, prefix, num = /([a-zA-Z]*)(\d+)/.match(id).to_a
        user_video?(prefix) ? thumbnail_url(num) : nil
      end

      private

      # @param num [String]
      # @return [String]
      def thumbnail_url(num)
        "http://tn-skr2.smilevideo.jp/smile?i=#{num}"
      end

      # @param prefix [String]
      # @return [Boolean]
      def user_video?(prefix)
        prefix == 'sm' || prefix == 'nm'
      end
    end
  end
end
