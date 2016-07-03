module TwitterInfrastructure
  class Tweet
    class << self
      def exec(client, text)
        client.update(text)
      end
    end
  end
end
