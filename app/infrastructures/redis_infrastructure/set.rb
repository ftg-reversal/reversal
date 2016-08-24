class RedisInfrastructure::Set
  class << self
    def exec(key, str)
      raise unless key.class == ::RedisInfrastructure::Key
      RedisInfrastructure::RedisClient.exec.set(key.to_s, str)
    end
  end
end
