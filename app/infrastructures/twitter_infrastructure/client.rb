require 'twitter'

module TwitterInfrastructure
  class Client
    class << self
      def exec
        @client ||= ::Twitter::REST::Client.new do |conf|
          conf.consumer_key        = ENV['TWITTER_CONSUMER_KEY']
          conf.consumer_secret     = ENV['TWITTER_CONSUMER_SECRET']
          conf.access_token        = ENV['TWITTER_ACCESS_TOKEN']
          conf.access_token_secret = ENV['TWITTER_ACCESS_TOKEN_SECRET']
        end
      end
    end
  end
end
