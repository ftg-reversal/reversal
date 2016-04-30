class TwitterApiRepository
  class << self
    def find_unsent_tweet(condition)
      find_by_text(condition.text).select { |tweet| tweet[:id] > condition.last_tweet }
    end

    def find_by_text(text)
      TwitterInfrastructure::Search.exec(text)
    end
  end
end
