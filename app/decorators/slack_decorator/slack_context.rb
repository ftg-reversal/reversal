class SlackDecorator::SlackContext
  class << self
    def context
      @context ||= {
        original_emoji_set: emoji,
        on_slack_user_id: on_slack_user_id,
        on_slack_user_name: on_slack_user_name,
        on_slack_channel_id: on_slack_channel_id
      }
    end

    def emoji
      @emoji ||= EmojiRepository.find_original_emoji_set
    end

    def on_slack_user_id
      -> (uid) do
        user = SlackUser.find_by(uid: uid)
        user ? { text: user.name, url: "https://#{ENV['SLACK_TEAM_NAME']}.slack.com/team/#{user.name}" } : nil
      end
    end

    def on_slack_user_name
      -> (name) do
        user = SlackUser.find_by(name: name)
        user ? { text: user.name, url: "https://#{ENV['SLACK_TEAM_NAME']}.slack.com/team/#{user.name}" } : nil
      end
    end

    def on_slack_channel_id
      -> (cid) do
        case cid[0]
        when 'C'
          name = SlackChannel.find_by(channel: cid).name
          { text: name, url: "/slack/channels/#{name}" }
        else
          { text: cid, url: nil }
        end
      end
    end
  end
end
