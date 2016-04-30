class EmojiRepository
  class << self
    def find_original_emoji_set
      SlackInfrastructure::Emoji.exec
    end

    def find_by_name(name)
      SlackInfrastructure::Emoji.exec[name]
    end
  end
end
