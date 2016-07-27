class OnlineBotBatch
  class << self
    ONLINE_BOT_LAST_TWEET = 'online_bot_last_tweet'.freeze

    def exec
      tweets = search_tweet
      unsent_tweets = tweets.select { |tweet| tweet[:id] > last_tweet_id }

      unsent_tweets.map do |tweet|
        TwitterInfrastructure::Tweet.exec(online_bot_client, tweet_text(tweet))
      end

      cache_last_tweet_id(unsent_tweets.last[:id])
    end

    private

    def online_bot_client
      TwitterInfrastructure::Client.online_bot_client
    end

    def search_tweet
      TwitterApiRepository.find_by_text('#GGXrdRプレマ').sort { |a, b| a[:id] <=> b[:id] }
    end

    def tweet_text(tweet)
      ".@#{tweet[:screen_name]} #{tweet[:text][0..100].gsub(/\#GGXrdRプレマ/i, '')} #{tweet[:url]}"
    end

    def last_tweet_id
      RedisInfrastructure::Get.exec(RedisInfrastructure::Key.online_bot_last_tweet).to_i
    rescue
      0
    end

    def cache_last_tweet_id(id)
      RedisInfrastructure::Set.exec(RedisInfrastructure::Key.online_bot_last_tweet, id.to_s)
    end
  end
end
