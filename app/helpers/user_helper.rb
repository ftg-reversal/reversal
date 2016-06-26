module UserHelper
  def external_user_link(user)
    if user.twitter_user
      img_tag = content_tag(:img, '', class: 'c-user-twitter-icon', src: asset_path('service_icon/twitter.png'))
      img_tag + twitter_user(user)
    else
      img_tag = content_tag(:img, '', class: 'c-user-twitter-icon', src: asset_path('service_icon/slack.png'))
      img_tag + "@#{user.slack_user.name}"
    end
  end

  private

  def twitter_user(user)
    content_tag(
      :a, "@#{user.twitter_user.screen_name}",
      class: 'user-twitter-link',
      href: "https://twitter.com/#{user.twitter_user.screen_name}",
      target: '_blank'
    )
  end
end
