module TwitterInfrastructure
  class Tweet
    class << self
      def exec(text)
        TwitterInfrastructure::Client.exec.update(text)
      end
    end
  end
end
