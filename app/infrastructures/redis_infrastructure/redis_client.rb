class RedisInfrastructure::RedisClient
  class << self
    def exec
      @client ||= Redis.new(url: ENV['REDIS_URL'])
    end
  end
end
