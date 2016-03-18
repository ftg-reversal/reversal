module Application
  class VideoUpdateNotificator
    class << self
      # @param video [Video]
      def tweet(video)
        TwitterInfrastructure.exec(tweet_text(video))
      end

      private

      def tweet_text(video)
        "\"#{video.title}\" - #{video.url} が投稿されました"
      end
    end
  end
end
