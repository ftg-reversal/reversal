class Twitter2slack
  class << self
    def exec
      Twitter2slackCondition.all.map do |condition|
        unsent_tweets = TwitterApiRepository.find_unsent_tweet(condition)
        unsent_tweets.map do |tweet|
          SlackApiRepository.post_message(condition.slack_channel, tweet[:url], 'twitter', icon_emoji: ':twitter:')
        end

        if condition.quote
          unsent_tweets.map do |tweet|
            TwitterInfrastructure::Tweet.exec(online_bot_client, "#{tweet[:text][0..100].gsub(/\#GGXrdRプレマ/, '').gsub(/\#GGXrdRロビー/, '')} #{tweet[:url]}")
          end
        end

        unless unsent_tweets.last.nil?
          condition.last_tweet = unsent_tweets.last[:id]
          condition.save
        end
      end
    end

    def online_bot_client
      TwitterInfrastructure::Client.online_bot_client
    end
  end
end
