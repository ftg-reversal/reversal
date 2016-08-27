require 'twitter'

module TwitterInfrastructure
  class Client
    class << self
      def dummy_client
        @dummy_client ||= ::Twitter::REST::Client.new
      end

      def official_client
        @official_client ||= ::Twitter::REST::Client.new do |conf|
          conf.consumer_key        = ENV['TWITTER_CONSUMER_KEY']
          conf.consumer_secret     = ENV['TWITTER_CONSUMER_SECRET']
          conf.access_token        = ENV['TWITTER_CONSUMER_ACCESS_TOKEN']
          conf.access_token_secret = ENV['TWITTER_CONSUMER_ACCESS_SECRET']
        end
      end

      def online_bot_client
        @online_bot_client ||= ::Twitter::REST::Client.new do |conf|
          conf.consumer_key        = ENV['TWITTER_ONLINE_BOT_CONSUMER_KEY']
          conf.consumer_secret     = ENV['TWITTER_ONLINE_BOT_CONSUMER_SECRET']
          conf.access_token        = ENV['TWITTER_ONLINE_BOT_ACCESS_TOKEN']
          conf.access_token_secret = ENV['TWITTER_ONLINE_BOT_ACCESS_SECRET']
        end
      end

      def ads_client
        @online_bot_client ||= ::Twitter::REST::Client.new do |conf|
          conf.consumer_key        = ENV['TWITTER_ADS_CONSUMER_KEY']
          conf.consumer_secret     = ENV['TWITTER_ADS_CONSUMER_SECRET']
          conf.access_token        = ENV['TWITTER_ADS_ACCESS_TOKEN']
          conf.access_token_secret = ENV['TWITTER_ADS_ACCESS_SECRET']
        end
      end
    end
  end
end
