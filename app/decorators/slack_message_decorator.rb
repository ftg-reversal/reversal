class SlackMessageDecorator < Draper::Decorator
  delegate_all

  def permalink
  end

  def format_text
    self.class.processor.call(object.text, self.class.context)[:output].to_s.html_safe
  end

  def attachment_items
    (object.attachments || []).map { |attachment|
      case attachment['service_name']
      when 'twitter'
        attachment
      when nil
        if attachment[:title] || attachment[:text]
          if attachment[:title_link]
            attachment[:title_link] = "https://slack-redir.net/link?url=#{URI.encode attachment[:title_link]}"
          end
          attachment
        elsif attachment[:image_url]
          attachment[:service_name] = 'reversal-image'
          attachment
        else
          nil
        end
      end
    }.compact
  end

  def image
    if object.file && object.file['mimetype'].include?('image')
      object['file']
    else
      nil
    end
  end

  def date
    Time.at(object.ts)
  end

  class << self
    def processor
      @prosessor ||= SlackMarkdown::Processor.new(
        asset_root: '/assets',
        cushion_link: 'https://slack-redir.net/link?url='
      )
    end

    def context
      @context ||= {
        original_emoji_set: self.emoji,
        on_slack_user_id: -> (uid) {
          Rails.cache.fetch("user_data_#{uid}", expires_in: 1.hours) do
            user = SlackUser.find_by(uid: uid)
            user ? {text: user.name, url: "https://#{ENV['SLACK_TEAM_NAME']}.slack.com/team/#{user.name}"} : nil
          end
        },
        on_slack_user_name: -> (name) {
          Rails.cache.fetch("user_data_#{name}", expires_in: 1.hours) do
            user = SlackUser.where(name: name).first
            user ? {text: user.name, url: "https://#{ENV['SLACK_TEAM_NAME']}.slack.com/team/#{user.name}"} : nil
          end
        },
        on_slack_channel_id: -> (cid) {
          Rails.cache.fetch("channel_data_#{cid}", expires_in: 1.hours) do
            case cid[0]
            when 'C'
              name = SlackChannel.find_by(channel: cid).name
              {text: name, url: "/slack/channels/#{name}"}
            else
              {text: cid, url: nil}
            end
          end
        }
      }
    end

    def emoji
      @emoji ||= SlackApiRepository.find_original_emoji_set
    end
  end
end
