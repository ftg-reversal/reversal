class OnlineBotBatch
  class << self
    ONLINE_BOT_LAST_TWEET = 'online_bot_last_tweet'.freeze

    def exec
      tweets = TwitterApiRepository.find_by_text('#GGXrdRプレマ').sort { |a, b| a[:id] <=> b[:id] }
      unsent_tweets = tweets.select { |tweet| tweet[:id] > REDIS.get(ONLINE_BOT_LAST_TWEET).to_i }

      unsent_tweets.map do |tweet|
        TwitterInfrastructure::Tweet.exec(online_bot_client, tweet_text(tweet))
      end

      unless unsent_tweets.last.nil?
        REDIS.set(ONLINE_BOT_LAST_TWEET, unset_tweets.last[:id].to_s)
      end
    end

    private

    def online_bot_client
      TwitterInfrastructure::Client.online_bot_client
    end

    def tweet_text(tweet)
      ".@#{tweet[:screen_name]} #{tweet[:text][0..100].gsub(/\#GGXrdRプレマ/, '')} #{tweet[:url]}"
    end
  end
end
