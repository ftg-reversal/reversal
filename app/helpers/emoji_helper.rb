module EmojiHelper
  def emojify(content)
    h(content).to_str.gsub(/:([\w+-]+):/) do |match|
      emoji = Emoji.find_by_alias($1)
      if emoji
        emoji.raw
      else
        match
      end
    end.html_safe if content.present?
  end
end
