class SummaryDecorator < Draper::Decorator
  delegate_all

  def description_html
    return '' unless object.description
    safe_html = h.html_escape(object.description.to_s)
    safe_html.gsub!(/https?:\/\/[^\s]+/) do |match|
      "<a href=\"https://slack-redir.net/link?url=#{h.html_escape match.to_s}\">#{match}</a>"
    end
    h.simple_format(safe_html)
  rescue => e
    Rails.logger.error "#{e.inspect} - #{e.backtrace}"
    object.description.to_s
  end

  def messages
    object.slack_messages.decorate
  end
end
