module TwitterInfrastructure
  class Search
    class << self
      SEARCH_COUNT = 100

      def exec(client, search_text)
        client.search("#{search_text} -rt").take(SEARCH_COUNT).map do |tweet|
          {
            id: tweet.id,
            screen_name: tweet.user.screen_name,
            text: tweet.text,
            url: "https://twitter.com/#{tweet.user.screen_name}/status/#{tweet.id}",
            created_at: tweet.created_at
          }
        end
      end
    end
  end
end
