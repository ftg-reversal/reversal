class RedisInfrastructure::Key
  def to_s
    @key.to_s
  end

  class << self
    def online_bot_last_tweet
      @online_bot_last_tweet ||= Key.new('ONLINE_BOT_LAST_TWEET'.freeze)
    end
  end

  private

  def initialize(key)
    @key = key
  end
end
