module TwitterHelper
  # rubocop:disable Metrics/LineLength
  def tw(url, text)
    content_tag(:a, 'tweet', href: "https://twitter.com/intent/tweet?button_hashtag=ftg_reversal&text=#{url_encode(text)}", class: 'twitter-hashtag-button', data: { size: 'large', url: url })
  end

  def good_tw(url, text, good = nil)
    content_tag :a, href: "https://twitter.com/share?url=#{url_encode(url)}&text=#{url_encode(text)}&hashtag=ftg_reversal", target: '_blank' do
      concat content_tag(:button, 'Tweet', class: 'tweet-button')
    end
  end
  # rubocop:enable Metrics/LineLength
end
