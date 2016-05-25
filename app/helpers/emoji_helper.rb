module EmojiHelper
  def emojify(content)
    EmojiParser.parse_tokens(content.to_s) do |emoji|
      path = [(emoji.custom? ? nil : 'emoji'), emoji.image_filename].compact.join('/')
      image_tag(path, class: 'emoji', alt: emoji.name)
    end.html_safe if content.present?
  end
end
