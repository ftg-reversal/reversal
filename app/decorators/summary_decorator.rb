class SummaryDecorator < Draper::Decorator
  delegate_all

  # rubocop:disable Metrics/AbcSize
  def description_html
    return '' unless object.description

    safe_html = h.html_escape(object.description.to_s)
    replace_link_with_slack(safe_html)
    h.simple_format(safe_html)
  rescue => e
    Rails.logger.error "#{e.inspect} - #{e.backtrace}"
    object.description.to_s
  end
  # rubocop:enable Metrics/AbcSize

  def messages
    object.slack_messages.decorate
  end

  private

  def replace_link_with_slack(html)
    html.gsub!(%r{https?://[^\s]+}) do |match|
      "<a href=\"https://slack-redir.net/link?url=#{h.html_escape match.to_s}\">#{match}</a>"
    end
  end
end
