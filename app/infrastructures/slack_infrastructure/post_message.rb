class SlackInfrastructure::PostMessage
  class << self
    def exec(channel, text, username, icon_emoji: nil, icon_url: nil)
      client = SlackInfrastructure::SlackClient.exec
      if !icon_emoji.nil?
        client.chat_postMessage(channel: channel, text: text, username: username, icon_emoji: icon_emoji)
      elsif !icon_url.nil?
        client.chat_postMessage(channel: channel, text: text, username: username, icon_url: icon_url)
      else
        client.chat_postMessage(channel: channel, text: text, username: username)
      end
    end
  end
end
