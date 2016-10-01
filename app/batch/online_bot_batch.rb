class OnlineBotBatch
  class << self
    TWITTER_ID = 'ggxrd_online'.freeze

    def exec
      tweets = search_tweet
      unsent_tweets = tweets.select { |tweet| unsent_tweet?(tweet) }

      unsent_tweets.map do |tweet|
        TwitterInfrastructure::Tweet.exec(online_bot_client, tweet_text(tweet))
      end

      cache_last_tweet_id(unsent_tweets.last[:id]) unless unsent_tweets.empty?
    end

    private

    def unsent_tweet?
      tweet[:id] > last_tweet_id && tweet[:screen_name] != TWITTER_ID
    end

    def online_bot_client
      TwitterInfrastructure::Client.online_bot_client
    end

    def search_tweet
      TwitterApiRepository.find_by_text('#GGXrdRプレマ')
    end

    def tweet_text(tweet)
      ".@#{tweet[:screen_name]} #{tweet[:text][0..80].gsub(/\#GGXrdRプレマ/i, '')} #{tweet[:url]}"
    end

    def last_tweet_id
      RedisInfrastructure::RedisGet.exec(RedisInfrastructure::RedisKey.online_bot_last_tweet).to_i
    end

    def cache_last_tweet_id(id)
      RedisInfrastructure::RedisSet.exec(RedisInfrastructure::RedisKey.online_bot_last_tweet, id.to_s)
    end
  end
end
