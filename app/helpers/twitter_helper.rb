module TwitterHelper
  # rubocop:disable Metrics/LineLength
  def tw(url, text)
    content_tag(:a, 'tweet', href: "https://twitter.com/intent/tweet?button&text=#{url_encode(text)}", class: 'twitter-hashtag-button', data: { size: 'large', url: url, hashtags: 'ftg_reversal' })
  end

  def good_tw(url, text)
    content_tag :a, href: "https://twitter.com/share?url=#{url_encode(url)}&text=#{url_encode(text)}&hashtags=ftg_reversal", target: '_blank', class: 'good-tweet-link' do
      concat content_tag(:button, 'Tweet', class: 'good-tweet-button')
    end
  end

  def good_tw_sm(url, text)
    content_tag :a, href: "https://twitter.com/share?url=#{url_encode(url)}&text=#{url_encode(text)}&hashtags=ftg_reversal", target: '_blank', class: 'good-tweet-sm-link' do
      concat content_tag(:button, 'Tweet', class: 'good-tweet-sm-button')
    end
  end
  # rubocop:enable Metrics/LineLength
end
