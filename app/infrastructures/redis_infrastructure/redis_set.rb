module RedisInfrastructure
  class RedisSet
    class << self
      attr_writer :client

      def exec(key, str)
        raise TypeError unless key.class == RedisKey
        client.set(key.to_s, str)
      end

      def client
        @client ||= RedisInfrastructure::RedisClient.exec
      end
    end
  end
end
