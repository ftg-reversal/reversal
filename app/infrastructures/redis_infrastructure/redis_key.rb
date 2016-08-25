module RedisInfrastructure
  class RedisKey
    def to_s
      @key.to_s
    end

    class << self
      def dummy_key
        @dummy_key ||= RedisKey.new('DUMMY_KEY'.freeze)
      end

      def online_bot_last_tweet
        @online_bot_last_tweet ||= RedisKey.new('ONLINE_BOT_LAST_TWEET'.freeze)
      end
    end

    private

    def initialize(key)
      @key = key
    end
  end
end
