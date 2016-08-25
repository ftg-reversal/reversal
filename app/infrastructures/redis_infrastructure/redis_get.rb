module RedisInfrastructure
  class RedisGet
    class << self
      attr_writer :client

      def exec(key)
        raise TypeError unless key.class == ::RedisInfrastructure::Key
        client.get(key.to_s)
      end

      private

      def client
        @client ||= RedisInfrastructure::RedisClient.exec
      end
    end
  end
end
