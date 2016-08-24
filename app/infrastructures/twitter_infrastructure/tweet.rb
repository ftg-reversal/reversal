class TwitterInfrastructure::Tweet
  class << self
    def exec(client, text)
      client.update(text)
    end
  end
end
