require 'twitter'

module TwitterInfrastructure
  class Tweet
    class << self
      # @param text [String]
      # @param config [Hash{String => String}]
      def exec(text, config = nil)
        client(config).update(text)
      end

      private

      # @param config [Hash{String => String}]
      # @return [::Twitter::REST::Client]
      def client(config)
        ::Twitter::REST::Client.new do |conf|
          conf.consumer_key        = config['consumer_key'] || ENV['TWITTER_CONSUMER_KEY']
          conf.consumer_secret     = config['consumer_secret'] || ENV['TWITTER_CONSUMER_SECRET']
          conf.access_token        = config['access_token'] || ENV['TWITTER_ACCESS_TOKEN']
          conf.access_token_secret = config['access_token_secret'] || ENV['TWITTER_ACCESS_TOKEN_SECRET']
        end
      end
    end
  end
end
