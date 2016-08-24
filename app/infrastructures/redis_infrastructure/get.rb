module RedisInfrastructure
  class Get
    class << self
      def exec(key)
        raise unless key.class == ::RedisInfrastructure::Key
        RedisInfrastructure::RedisClient.exec.get(key.to_s)
      end
    end
  end
end
