module TwitterHelper
  # rubocop:disable Metrics/LineLength
  def tw(url, text)
    content_tag(:a, 'tweet', href: "https://twitter.com/intent/tweet?button_hashtag=ftg_reversal&text=#{text}", class: 'twitter-hashtag-button', data: { size: 'large', url: url })
  end
  # rubocop:enable Metrics/LineLength
end
