Rails.application.config.middleware.use OmniAuth::Builder do
  provider :slack,
           ENV['SLACK_CLIENT_ID'],
           ENV['SLACK_CLIENT_SECRET'],
           scope: 'identify,read',
           team: ENV['SLACK_TEAM_ID']

  provider :twitter,
           ENV['TWITTER_CONSUMER_KEY'],
           ENV['TWITTER_CONSUMER_SECRET'],
           secure_image_url: 'true',
           image_size: 'bigger'
end
